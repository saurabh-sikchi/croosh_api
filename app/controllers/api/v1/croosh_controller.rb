require 'securerandom'

class Api::V1::CrooshController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user_request!, except: [:party_mode, :toggle_celeb_like, :increment_share, :create]
  before_action :authenticate_user_or_celeb_request!, only: [:party_mode, :increment_share]
  before_action :authenticate_celeb_request!, only: [:toggle_celeb_like, :create]

  def party_mode
    crooshes = Croosh.get_random_for_party_mode(params[:crooshes_already_seen])
    data = [].tap do |h|
      crooshes.each do |croosh|
        video_url = asset_url(croosh.video)
        thumbnail = asset_url(croosh.thumbnail)
        celeb = croosh.celeb
        celeb_profile_pic = asset_url(celeb.profile_pic)
        liked = @current_celeb ? croosh.liked_by_celeb?(@current_celeb) : croosh.liked_by_user?(@current_user)
        h.push({
          croosh_id: croosh.id,
          video_url: video_url,
          total_likes_count: croosh.user_likes_count + croosh.celeb_likes_count,
          thumbnail: thumbnail,
          celeb_name: celeb.name,
          celeb_nick: celeb.nick,
          celeb_rate_per_croosh: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', lakh: 'l'  } ),
          rate_per_croosh_in_paisa: celeb.rate_per_croosh * 100,
          celeb_profile_pic: celeb_profile_pic,
          celeb_id: celeb.id,
          liked: liked
        })
      end
    end
    render json: { crooshes: data }, status: 200
  end

  def toggle_user_like
    croosh = Croosh.find(params[:croosh_id])
    ul = UserLike.find_by(croosh: croosh, user: @current_user)
    if ul.present?
      ul.destroy
      render json: { like: false }
    else
      UserLike.create(croosh: croosh, user: @current_user)
      render json: { like: true }
    end
  end

  def toggle_celeb_like
    croosh = Croosh.find(params[:croosh_id])
    cl = CelebLike.find_by(croosh: croosh, celeb: @current_celeb)
    if cl.present?
      cl.destroy
      render json: { like: false }
    else
      CelebLike.create(croosh: croosh, celeb: @current_celeb)
      render json: { like: true }
    end
  end

  def increment_share
    croosh = Croosh.find(params[:croosh_id])
    us = UserShare.find_by(croosh: croosh, user: @current_user)
    if us.present?
      us.num += 1
      us.save
      render json: { success: true }
    else
      UserShare.create(croosh: croosh, user: @current_user, num: 1)
      render json: { success: true }
    end
  end

  def create
    croosh = Croosh.find(params[:croosh_id])
    croosh.video.attach(params[:video])
    croosh.is_request = false
    croosh.save!

    render json: { success: true }
  end

  def create_croosh_request
    Rails.logger.info "params = #{params}"
    Razorpay::Payment.fetch(params[:razorpay_payment_id]).capture({
      amount: params[:amount].to_i
    })
    croosh = Croosh.create!(
      celeb_id: params[:celeb_id],
      to_complete_date: params[:to_complete_date],
      request_text: params[:request_text],
      user: @current_user,
      created_at: Date.today,
      is_request: true
    )

    render json: { success: true, croosh_id: croosh.id }
  end

  def user_create
    celeb = Celeb.find params[:celeb_id]
    to_complete_date = params[:to_complete_date]
    croosh = Croosh.create!(
      is_request: true, 
      user: @current_user, 
      celeb: celeb, 
      to_complete_date: to_complete_date,
      request_text: params[:request_text]
    )
    render json: { success: true, croosh_id: croosh.id }
  end

  def order_token
    Rails.logger.info "params = #{params}"
    options = { 
      amount: params[:amount].to_i, 
      currency: 'INR', 
      receipt: SecureRandom.alphanumeric(24), 
      payment_capture: '0'
    }
    order = Razorpay::Order.create(options)
    render json: {
      order_token: order.id,
      amount: order.amount,
      email: @current_user.email
    }
  end

end

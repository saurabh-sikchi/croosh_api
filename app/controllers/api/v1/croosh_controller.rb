class Api::V1::CrooshController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user_request!, except: [:party_mode, :toggle_celeb_like]
  before_action :authenticate_user_or_celeb_request!, only: :party_mode
  before_action :authenticate_celeb_request!, only: :toggle_celeb_like

  def party_mode
    crooshes = Croosh.get_random_for_party_mode(params[:crooshes_already_seen])
    liked = @current_celeb ? croosh.liked_by_celeb?(@current_celeb) : croosh.liked_by_user?(@current_user) ?
    data = [].tap do |h|
      crooshes.each do |croosh|
        video_url = asset_url(croosh.video)
        thumbnail = asset_url(croosh.thumbnail)
        celeb = croosh.celeb
        celeb_profile_pic = asset_url(celeb.profile_pic)
        h.push({
          croosh_id: croosh.id,
          video_url: video_url,
          total_likes_count: croosh.user_likes_count + croosh.celeb_likes_count,
          thumbnail: thumbnail,
          celeb_name: celeb.name,
          celeb_nick: celeb.nick,
          celeb_rate_per_croosh: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', lakh: 'l'  } ),
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
      UserLike.create(croosh: croosh, celeb: @current_celeb)
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

end

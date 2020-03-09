class Api::V1::CelebConnectController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :authenticate_celeb_request!

  def index
    crooshes = @current_celeb.get_crooshes_for_connect(params[:sort_order]).inject([]) do |h, croosh|
      rm_inputs = croosh.rm_inputs
      video_url = asset_url(croosh.video)
      thumbnail = asset_url(croosh.thumbnail)
      h.push({
        croosh_id: croosh.id,
        image: asset_url(croosh.user.profile_pic),
        notificationCount: 1+rm_inputs.count,
        date: croosh.to_complete_date.try(:strftime, '%b %-d, %Y'),
        completed: !croosh.is_request?,
        requestorName: croosh.user.name,
        request: croosh.request_text,
        rmInputs: croosh.rm_inputs.pluck(:input_text),
        rmName: (croosh.rm_inputs.last.try(:name) || ''),
        croosh_video_url: video_url,
        thumbnail: thumbnail
      })
    end
    render json: {
      celeb_id: @current_celeb.id,
      crooshes: crooshes,
    }, status: 200
  end

  def show
    celeb = @current_celeb
    profile_video_url = asset_url(celeb.profile_video)
    render json: {
      celeb_id: celeb.id,
      title: celeb.name,
      id: celeb.nick,
      amount: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', lakh: 'l'  } ),
    }, status: 200
  end
end

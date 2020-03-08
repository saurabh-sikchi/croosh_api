class Api::V1::UserCelebsController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user_request!, except: :celeb_profile
  before_action :authenticate_user_or_celeb_request!, only: :celeb_profile

  def connect_mode
    celebs = Celeb.get_for_connect_mode(params[:celebs_already_seeen], params[:sort_order])
    data = [].tap do |a|
      celebs.each do |celeb|
        link_to_profile_pic = asset_url(celeb.profile_pic)
        a << {
          celeb_id: celeb.id,
          name: celeb.name,
          nick: celeb.nick,
          rate_per_croosh: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', lakh: 'l'  } ),
          profile_pic: link_to_profile_pic
        }
      end
    end
    render json: { celebs: data }, status: 200
  end

  def celeb_profile
    celeb = Celeb.live_only.find(params[:celeb_id])
    crooshes = celeb.crooshes.not_requests.inject([]) do |h, croosh|
      video_url = asset_url(croosh.video)
      thumbnail = asset_url(croosh.thumbnail)
      updates = croosh.croosh_updates.map(&:update_text)
      h.push({
        croosh_id: croosh.id,
        total_likes_count: croosh.user_likes_count + croosh.celeb_likes_count,
        thumbnail: thumbnail,
        date: croosh.created_at.strftime('%b %-d, %Y'),
        video_url: video_url,
        updates: updates,
        is_request: croosh.is_request?,
      })
    end
    profile_video_url = asset_url(celeb.profile_video)
    render json: {
      celeb_id: celeb.id,
      name: celeb.name,
      profile_video: profile_video_url,
      known_for: celeb.known_for,
      rate_per_croosh: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', lakh: 'l'  } ),
      crooshes: crooshes,
    }, status: 200
  end
end

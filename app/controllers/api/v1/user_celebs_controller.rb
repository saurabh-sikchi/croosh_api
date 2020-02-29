class Api::V1::UserCelebsController < ApplicationController

  include ActionView::Helpers::NumberHelper

  before_action :authenticate_user_request!

  def connect_mode
    # TODO pagination
    celebs = Celeb.get_random_for_connect_mode(params[:celebs_already_seeen])
    # data = {}.tap do |h|
    #   celebs.each do |celeb|
    #     link_to_profile_pic = celeb.profile_pic.present? ? url_for(celeb.profile_pic) : ''
    #     h[celeb.id] = {
    #       name: celeb.name,
    #       nick: celeb.nick,
    #       rate_per_croosh: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', million: 'm'  } ),
    #       profile_pic: link_to_profile_pic
    #     }
    #   end
    # end
    data = [].tap do |a|
      celebs.each do |celeb|
        link_to_profile_pic = celeb.profile_pic.present? ? url_for(celeb.profile_pic) : ''
        a << {
          celeb_id: celeb.id,
          name: celeb.name,
          nick: celeb.nick,
          rate_per_croosh: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', million: 'm'  } ),
          profile_pic: link_to_profile_pic
        }
      end
    end
    render json: { celebs: data }, status: 200
  end

  def celeb_profile
    celeb = Celeb.live_only.find(params[:celeb_id])
    crooshes = celeb.crooshes.inject([]) do |h, croosh|
      video_url = croosh.video.present? ? url_for(croosh.video) : ''
      thumbnail = croosh.video.present? ? url_for(croosh.thumbnail) : ''
      h.push({
        croosh_id: croosh.id,
        total_likes_count: croosh.user_likes_count + croosh.celeb_likes_count,
        thumbnail: thumbnail,
        date: croosh.created_at.strftime('%b %-d, %Y'),
        video_url: video_url,
      })
    end
    profile_video_url = celeb.profile_video.present? ? url_for(celeb.profile_video) : ''
    render json: {
      celeb_id: celeb.id,
      name: celeb.name,
      profile_video: profile_video_url,
      known_for: celeb.known_for,
      rate_per_croosh: number_to_human(celeb.rate_per_croosh, precision: 2, format: "%n%u", units: { thousand: 'k', million: 'm'  } ),
      crooshes: crooshes,
    }, status: 200
  end
end

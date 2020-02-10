class Api::V1::CrooshController < ApplicationController

  before_action :authenticate_user_request!

  def party_mode
    crooshes = Croosh.get_random_for_party_mode(params[:crooshes_already_seen])
    data = {}.tap do |h|
      crooshes.each do |croosh|
        video_url = croosh.video.present? ? url_for(croosh.video) : ''
        thumbnail = croosh.video.present? ? url_for(croosh.thumbnail) : ''
        h[croosh.id] = {
          video_url: video_url,
          user_likes_count: croosh.user_likes_count,
          celeb_likes_count: croosh.celeb_likes_count,
          thumbnail: thumbnail
        }
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

end

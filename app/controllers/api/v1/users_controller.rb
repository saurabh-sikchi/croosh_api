class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user_request!

  def profile
    crooshes = @current_user.crooshes
    data = [].tap do |h|
      crooshes.each do |croosh|
        video_url = asset_url(croosh.video)
        thumbnail_url = asset_url(croosh.thumbnail)
        updates = croosh.croosh_updates.map(&:update_text)
        h.push([
          croosh_id: croosh.id,
          video_url: video_url,
          total_likes_count: croosh.user_likes_count + croosh.celeb_likes_count,
          date: croosh.created_at.strftime('%b %-d, %Y'),
          celeb_profile_pic: asset_url(croosh.celeb.profile_pic),
          thumbnail: thumbnail_url,
          updates: updates,
          is_request: croosh.is_request?,
        ])
      end
    end
    render json: { user_name: @current_user.name, crooshes: data }, status: 200
  end

  def change_profile_pic
    @current_user.profile_pic.attach(io: image_io, filename: image_name)
    render json: { success: true, image_url: asset_url(@current_user.profile_pic) }
  end

  def change_name
    updated = @current_user.update_attributes(name: params[:name])
    render json: { success: updated, name: @current_user.name }, status: 200
  end

  private

  def image_io
    decoded_image = Base64.decode64(params[:image])
    StringIO.new(decoded_image)
  end

  def image_name
    params[:file_name]
  end

end

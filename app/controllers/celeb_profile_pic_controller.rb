class CelebProfilePicController < ApplicationController

  before_action :authenticate_celeb_request!

  def show
    render json: {
      profile_pic: asset_url(@current_celeb.profile_pic)
    }, status: 200
  end

end

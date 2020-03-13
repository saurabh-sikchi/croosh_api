class Api::V1::UserProfilePicController < ApplicationController

  before_action :authenticate_user_request!

  def show
    render json: {
      profile_pic: asset_url(@current_user.profile_pic)
    }, status: 200
  end

end

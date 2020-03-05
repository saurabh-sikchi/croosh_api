class Api::V1::OtpAuthenticationController < ApplicationController
  
  def send_otp
    puts params
    result = OtpAuthentication.send_to_number(params[:phone_number])
    render json: result, status: 200
  end

  def verify_otp_and_login
    user = OtpAuthentication.verify(params[:phone_number], params[:otp])
    if user.present?
      render json: {
        auth_token: user.generate_jwt_token,
        link_to_profile_pic: asset_url(user.profile_pic)
      }, status: 200
    else
      render json: { success: false }, status: 200
    end
  end

end
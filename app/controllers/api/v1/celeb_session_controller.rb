class Api::V1::CelebSessionController < ApplicationController

  def create
    celeb = Celeb.find_by(nick: params[:nick]).try(:authenticate, params[:password])
    if celeb.present?
       render json: { success: true, auth_token: celeb.generate_jwt_token }
    else
       render json: { success: false }
    end
  end
end

class Api::V1::CelebController < ApplicationController

  def create

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST'

    password ="#{LiterateRandomizer.word.capitalize}#{LiterateRandomizer.word.capitalize}"

    celeb = Celeb.new(
      name: params[:celeb_name],
      nick: params[:celeb_username],
      rate_per_croosh: params[:celeb_amount],
      email: params[:celeb_email], # add
      known_for: params[:celeb_bio],
      phone_number: params[:celeb_phone], # add
      address: params[:celeb_address], # add
      password: password,
      password_confirmation: password,
      password_plaintext: password,
    )

    celeb.profile_pic.attach(params[:celeb_photo])
    celeb.profile_video.attach(params[:celeb_video])

    if celeb.save
      render json: {
        success: true
      }, status: 200
    else
      render json: {
        error: celeb.errors.full_messages.join("; ") 
      }, status: 200
    end
  end

end
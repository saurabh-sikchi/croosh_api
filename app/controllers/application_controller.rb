class ApplicationController < ActionController::API
  require 'json_web_token'

  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  protected

  # Validates the token and user and sets the @current_user scope
  def authenticate_user_request!
    if !payload || !JsonWebToken.valid_payload?(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  def authenticate_celeb_request!
    if !payload || !JsonWebToken.valid_payload?(payload.first)
      return invalid_authentication
    end

    load_current_celeb!
    invalid_authentication unless @current_celeb
  end

  def authenticate_user_or_celeb_request!
    if !payload || !JsonWebToken.valid_payload?(payload.first)
      return invalid_authentication
    end

    load_current_celeb!
    load_current_user!
    invalid_authentication unless @current_celeb || @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: { error: 'Unauthenticated Request' }, status: :unauthorized
  end

  def asset_url(active_storage_obj)
    return '' unless active_storage_obj.present?
    if Rails.env.development? || !active_storage_obj.respond_to?(:key)
      return url_for(active_storage_obj)
    else
      h = Rails.application.config.cdn_host
      return "#{h}#{active_storage_obj.key}"
    end
  end

  private

  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    return unless auth_header.present?
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

  def load_current_celeb!
    @current_celeb = Celeb.find_by(id: payload[0]['celeb_id'])
  end
end

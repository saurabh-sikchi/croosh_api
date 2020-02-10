require 'jwt'

class JsonWebToken
  
  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(payload)
    JWT.decode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.valid_payload?(payload)
    return payload['iss'] == meta[:iss] && payload['aud'] == meta[:aud]
  end

  def self.meta
    {
      iss: 'croosh_api',
      aud: 'client'
    }
  end

end
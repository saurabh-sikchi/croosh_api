require 'uri'
require 'net/http'

class SmsClient

  API_ENDPOINT = "https://api.msg91.com/api/v2/sendsms"
  
  def self.send_sms(to:, text:)
    return true if Rails.env.development?

    url = URI(API_ENDPOINT)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["authkey"] = CrooshApi::Application.credentials.msg91_authkey
    request["content-type"] = 'application/json'

    # json_body = {
    #   "sender"=>"CROOSH", 
    #   "route"=>"4", 
    #   "country"=>"91", 
    #   "sms"=> [ {"message"=>text, "to"=>[to]} ]
    # }

    # request.body = json_body.to_s

    request.body = "{ \"sender\": \"CROOSH\", \"route\": \"4\", \"country\": \"91\", \"sms\": [ { \"message\": \"#{text}\", \"to\": [ \"#{to}\" ] } ] }"

    2.times do
      response = http.request(request)
      if response.code == "200"
        return true
      else
        Rails.logger.info "SMS sending failed ---------------"
        Rails.logger.info response.code
        Rails.logger.info response.read_body
        Rails.logger.info "---------------"
      end
    end
    return false
  end

end
# == Schema Information
#
# Table name: otp_authentications
#
#  id           :bigint           not null, primary key
#  phone_number :string(255)      not null
#  otp          :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  succeeded    :boolean          default(FALSE), not null
#  user_id      :integer
#

class OtpAuthentication < ApplicationRecord

  validates :phone_number, format: { with: /\A[0-9]{10}\z/, message: 'should be 10 digit' }
  belongs_to :user, optional: true

  scope :within_last_five_minutes, -> { where('created_at >= ?', Time.zone.now - 5.minutes) }
  scope :succeeded, -> { where(succeeded: true) }
  scope :not_succeeded, -> { where(succeeded: false) }

  def self.send_to_number(phone_number)
    otp_auth = self.within_last_five_minutes.not_succeeded.where(phone_number: phone_number).last || self.new(phone_number: phone_number, otp: get_random_otp(phone_number))
    if otp_auth.valid?
      sent = SmsClient.send_sms(to: otp_auth.phone_number, text: otp_auth.generate_text)
      if sent
        otp_auth.save
        return { success: true }
      else
        return { success: false, error: 'There is an issue with sending sms. Please try again after some time' }
      end
    else
      return { success: false, error: otp_auth.errors.full_messages.first }
    end
  end

  def self.verify(phone_number, otp)
    otp_auth = self.within_last_five_minutes.not_succeeded.where(phone_number: phone_number, otp: otp).last
    return if otp_auth.nil?
      
    prev_otp_auth = self.succeeded.where(phone_number: phone_number).last
    user = prev_otp_auth.try(:user) || User.create
    otp_auth.update_attributes(user_id: user.id, succeeded: true)
    return user
  end

  def generate_text
    "Your OTP for croosh is #{otp}."
  end

  private

  def self.get_random_otp(phone_number = nil)
    return 335 if phone_number == '0123456789'
    rand(100..999)
  end

end

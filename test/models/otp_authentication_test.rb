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

require 'test_helper'

class OtpAuthenticationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

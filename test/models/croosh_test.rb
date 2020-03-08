# == Schema Information
#
# Table name: crooshes
#
#  id                :bigint           not null, primary key
#  celeb_id          :bigint           not null
#  user_id           :bigint           not null
#  user_likes_count  :integer          default(0), not null
#  celeb_likes_count :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_shares_count :integer          default(0), not null
#  is_request        :boolean          default(FALSE), not null
#  request_text      :text(65535)
#  to_complete_date  :date
#

require 'test_helper'

class CrooshTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

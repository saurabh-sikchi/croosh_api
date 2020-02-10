# == Schema Information
#
# Table name: celeb_likes
#
#  id         :bigint           not null, primary key
#  celeb_id   :bigint           not null
#  croosh_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CelebLikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

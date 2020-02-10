# == Schema Information
#
# Table name: celeb_known_fors
#
#  id           :bigint           not null, primary key
#  celeb_id     :bigint           not null
#  known_for_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CelebKnownForTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

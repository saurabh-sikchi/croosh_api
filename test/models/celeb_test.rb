# == Schema Information
#
# Table name: celebs
#
#  id               :bigint           not null, primary key
#  name             :string(255)
#  nick             :string(255)
#  rate_per_croosh  :integer
#  ready_to_go_live :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class CelebTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

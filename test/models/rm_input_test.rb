# == Schema Information
#
# Table name: rm_inputs
#
#  id         :bigint           not null, primary key
#  input_text :text(65535)
#  name       :string(255)      default(""), not null
#  croosh_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RmInputTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

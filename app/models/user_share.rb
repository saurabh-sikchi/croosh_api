# == Schema Information
#
# Table name: user_shares
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  croosh_id  :bigint           not null
#  num        :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserShare < ApplicationRecord
  belongs_to :user
  belongs_to :croosh

  before_save :update_croosh_user_shares_count

  def update_croosh_user_shares_count
    croosh.update_attribute(:user_shares_count, croosh.user_shares_count - num_was + num)
  end

end

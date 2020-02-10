# == Schema Information
#
# Table name: user_likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  croosh_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserLike < ApplicationRecord
  belongs_to :user
  belongs_to :croosh, counter_cache: true
end

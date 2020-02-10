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

class CelebLike < ApplicationRecord
  belongs_to :celeb
  belongs_to :croosh, counter_cache: true
end

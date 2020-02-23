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
#

class Croosh < ApplicationRecord
  belongs_to :celeb
  belongs_to :user

  has_many :user_likes
  has_many :celeb_likes

  has_one_attached :video

  scope :exclude, ->(ids) { where.not(id: ids) }

  def self.get_random_for_party_mode(crooshes_already_seen = [])
    celebs = self.exclude(crooshes_already_seen).order('RAND()')
  end

  def thumbnail
    video.preview(resize_to_limit: [200, 200])
  end

  def liked_by?(user)
    user_likes.where(user: user).exists?
  end
end

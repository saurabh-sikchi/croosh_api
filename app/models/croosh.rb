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
#

class Croosh < ApplicationRecord
  belongs_to :celeb
  belongs_to :user

  has_many :user_likes, dependent: :destroy
  has_many :celeb_like, dependent: :destroy
  has_many :user_share, dependent: :destroy

  has_one_attached :video, dependent: :purge

  has_many :croosh_updates, dependent: :destroy

  scope :exclude, ->(ids) { where.not(id: ids) }
  scope :not_requests, -> { where(is_request: false) }

  def self.get_random_for_party_mode(crooshes_already_seen = [])
    celebs = self.not_requests.exclude(crooshes_already_seen).order('RAND()')
  end

  def thumbnail
    return nil unless video.present?
    video.preview(resize: "200x200")
  end

  def liked_by?(user)
    user_likes.where(user: user).exists?
  end

end

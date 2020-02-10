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

class Celeb < ApplicationRecord
  validates :name, presence: true
  validates :nick, presence: true
  validates :rate_per_croosh, numericality: { greater_than: 0 }

  has_many_attached :pics
  has_one_attached :profile_video

  has_many :crooshes
  has_many :celeb_known_fors
  has_many :known_fors, through: :celeb_known_fors

  scope :exclude, ->(ids) { where.not(id: ids) }
  scope :live_only, -> { where(ready_to_go_live: true) }

  def self.get_random_for_connect_mode(celebs_already_seen = [])
    celebs = self.live_only.exclude(celebs_already_seen).order('RAND()')
  end

  def profile_pic
    pics.first
  end

  def known_for_as_string
    known_fors.pluck(:name).join(', ')
  end
end

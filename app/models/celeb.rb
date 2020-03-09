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
#  known_for        :text(65535)
#  password_digest  :string(255)
#

class Celeb < ApplicationRecord
  validates :name, presence: true
  validates :nick, presence: true, uniqueness: true
  validates :rate_per_croosh, numericality: { greater_than: 0 }

  has_one_attached :profile_pic, dependent: :purge
  has_one_attached :profile_video, dependent: :purge

  has_many :crooshes
  has_many :celeb_known_fors
  has_many :known_fors, through: :celeb_known_fors

  has_secure_password

  scope :exclude, ->(ids) { where.not(id: ids) }
  scope :live_only, -> { where(ready_to_go_live: true) }

  def self.get_for_connect_mode(celebs_already_seen = [], sort_order = 'fresh')
    celebs = self.live_only.exclude(celebs_already_seen)
    case sort_order
    when 'num_likes'
      return celebs.select('celebs.*, SUM(crooshes.user_likes_count + crooshes.celeb_likes_count) as num_likes').joins('LEFT OUTER JOIN crooshes ON crooshes.celeb_id = celebs.id').group('celebs.id').order('num_likes DESC, celebs.updated_at DESC')
    when 'num_crooshes'
      return celebs.select('celebs.*, COUNT(crooshes.id) as num_crooshes').joins('LEFT OUTER JOIN crooshes ON crooshes.celeb_id = celebs.id').group('celebs.id').order('num_crooshes DESC, celebs.updated_at DESC')
    when 'num_shares'
      return celebs.select('celebs.*, SUM(crooshes.user_shares_count) as num_shares').joins('LEFT OUTER JOIN crooshes ON crooshes.celeb_id = celebs.id').group('celebs.id').order('num_shares DESC, celebs.updated_at DESC')
    else
      return celebs.order('celebs.updated_at DESC')
    end
  end

  def get_crooshes_for_connect(sort_order = 'expiring_first')
    case sort_order
    when 'num_likes'
      return crooshes.order('num_likes DESC')
    when 'fresh'
      return crooshes.order('created_at DESC')
    when 'num_shares'
      return crooshes.order('user_shares_count DESC')
    else
      return crooshes.order('to_complete_date DESC')
    end
  end

  def known_for_as_string
    known_fors.pluck(:name).join(', ')
  end

  def generate_jwt_token
    return JsonWebToken.encode({ celeb_id: id })
  end
end

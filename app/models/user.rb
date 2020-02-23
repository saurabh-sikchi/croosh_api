# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class User < ApplicationRecord

  has_one_attached :profile_pic
  has_many :crooshes, -> { order(created_at: :desc) }

  after_create :attach_default_profile_pic
  def attach_default_profile_pic
    self.profile_pic.attach(io: File.open('lib/avatar-default.jpg'), filename: 'default.jpg')
  end

  def generate_jwt_token
    return JsonWebToken.encode({ user_id: id })
  end

end

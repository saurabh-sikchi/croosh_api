# == Schema Information
#
# Table name: known_fors
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class KnownFor < ApplicationRecord
  validates :name, presence: true
end

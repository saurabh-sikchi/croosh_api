# == Schema Information
#
# Table name: croosh_updates
#
#  id        :bigint           not null, primary key
#  croosh_id :bigint           not null
#  update    :text(65535)
#

class CrooshUpdate < ApplicationRecord
  belongs_to :croosh
end

# == Schema Information
#
# Table name: scores
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Score < ApplicationRecord

  validates :name, presence: true
  validates :value, presence: true


  attribute :data, :jsonb, default: {}

  def to_s
    name
  end
end

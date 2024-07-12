
class Score < ApplicationRecord

  validates :name, presence: true
  validates :value, presence: true


  attribute :data, :jsonb, default: {}

  def to_s
    name
  end
end

class Score < ApplicationRecord

  validates :name, presence: true
  validates :value, presence: true

  scope :by_value, ->(direction = :asc) { order(value: direction) }
  attribute :data, :jsonb, default: {}

  def to_s
    name
  end
end
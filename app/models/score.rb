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
  has_many :lead_histories

  attribute :data, :jsonb, default: {}

  def to_s
    name
  end
  def register_send(destination)
    self.lead_histories.create(sent_at: Time.current, destination: destination)
  end
end

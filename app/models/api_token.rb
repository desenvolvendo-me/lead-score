class ApiToken < ApplicationRecord
  belongs_to :user
  belongs_to :client

  validates :token, presence: true, uniqueness: true
end

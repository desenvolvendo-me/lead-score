# == Schema Information
#
# Table name: api_tokens
#
#  id         :bigint           not null, primary key
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_api_tokens_on_client_id  (client_id)
#  index_api_tokens_on_token      (token) UNIQUE
#  index_api_tokens_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (user_id => users.id)
#
class ApiToken < ApplicationRecord
  belongs_to :user
  belongs_to :client

  validates :token, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: clients
#
#  id                   :bigint           not null, primary key
#  current_period_end   :datetime
#  current_period_start :datetime
#  document             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  stripe_customer_id   :string
#  user_id              :bigint
#
# Indexes
#
#  index_clients_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:goals).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:document) }
  end
end

# == Schema Information
#
# Table name: goals
#
#  id          :bigint           not null, primary key
#  description :string
#  finished_at :datetime
#  name        :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :integer
#
FactoryBot.define do
  factory :goal do
    name { FFaker::Name.name }
    description { FFaker::Lorem.sentence }
    status { 'todo' }
    association :client
  end
end

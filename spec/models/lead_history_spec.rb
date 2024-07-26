# == Schema Information
#
# Table name: lead_histories
#
#  id          :bigint           not null, primary key
#  destination :string
#  lead        :string
#  sent_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe LeadHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

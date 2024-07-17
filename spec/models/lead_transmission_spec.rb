# == Schema Information
#
# Table name: lead_transmissions
#
#  id                  :bigint           not null, primary key
#  max_score_threshold :integer
#  min_score_threshold :integer
#  webhook_url         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe LeadTransmission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

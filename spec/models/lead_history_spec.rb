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
#  score_id    :bigint           not null
#
# Indexes
#
#  index_lead_histories_on_score_id  (score_id)
#
# Foreign Keys
#
#  fk_rails_...  (score_id => scores.id)
#
require 'rails_helper'

RSpec.describe LeadHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

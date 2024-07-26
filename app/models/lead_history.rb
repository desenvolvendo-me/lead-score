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
class LeadHistory < ApplicationRecord
  belongs_to :lead
end

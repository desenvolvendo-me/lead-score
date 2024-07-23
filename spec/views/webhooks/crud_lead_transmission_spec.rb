require 'rails_helper'

RSpec.feature 'LeadTransmissions', type: :feature do
  let(:user) { create(:user) }  # Supondo que você tenha um factory para user
  let(:lead_transmission) { create(:lead_transmission) }

  before do
    login_as(user, scope: :user)
  end

  scenario 'User visits the index page' do
    visit webhooks_lead_transmissions_path
    expect(page).to have_content('Lead Transmissions')
  end

  scenario 'User views a lead transmission' do
    visit webhooks_lead_transmission_path(lead_transmission)
    expect(page).to have_content(lead_transmission.webhook_url)
  end

  scenario 'User creates a new lead transmission' do
    visit new_webhooks_lead_transmission_path

    fill_in 'Webhook url', with: 'http://example.com'
    fill_in 'Min score threshold', with: 10
    fill_in 'Max score threshold', with: 100

    expect(page).to have_button('Create Lead Transmission')
    click_button 'Create Lead Transmission'

    expect(page).to have_content('Lead transmission was successfully created.')
    expect(page).to have_content('http://example.com')
  end

  scenario 'User edits a lead transmission' do
    visit edit_webhooks_lead_transmission_path(lead_transmission)

    fill_in 'Webhook url', with: 'http://newexample.com'
    fill_in 'Min score threshold', with: 20
    fill_in 'Max score threshold', with: 90

    click_button 'Update Lead Transmission'

    expect(page).to have_content('Lead transmission was successfully updated.')
    expect(page).to have_content('http://newexample.com')
  end

  scenario 'User deletes a lead transmission' do
    lead_transmission = create(:lead_transmission)
    visit webhooks_lead_transmissions_path
    expect(page).to have_button('Delete')

    accept_confirm do
      click_button 'Delete'
    end
    sleep 2
    expect(LeadTransmission.count).to eq(0)
    expect(page).to have_content('Lead transmission was successfully destroyed.')
  end
end

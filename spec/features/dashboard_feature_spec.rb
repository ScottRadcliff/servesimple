require 'rails_helper'

describe 'Dashboard' do
  let!(:fft_account) { create(:account, subdomain: 'fft', name: 'Food for Thought') }
  let!(:idhc_account) { create(:account, subdomain: 'idhc', name: 'Iglesia Dedios Hermandad Cristiana') }

  it 'shows correct Dashboard for account subdomain' do
    visit root_url(subdomain: 'fft')

    expect(page).to have_content('ServeSimple')
    expect(page).to have_content('Food for Thought')

    visit root_url(subdomain: 'idhc')

    expect(page).to have_content('ServeSimple')
    expect(page).to have_content('Iglesia Dedios Hermandad Cristiana')
  end

  it 'shows 404 for non-existant account subdomain' do
    visit root_url(subdomain: 'foo')
    expect(page.status_code).to eq(404)
  end
end

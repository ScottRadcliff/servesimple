require 'rails_helper'

describe 'Homepage' do
  let!(:account) { create(:account, subdomain: 'fft', name: 'Food for Thought') }

  it 'shows coming soon' do
    visit root_url(subdomain: "")

    expect(page).to have_content('ServeSimple')
    expect(page).to have_content('Coming Soon')
  end
end

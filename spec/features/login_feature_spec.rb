require 'rails_helper'

describe 'Login' do
  let!(:account) { create(:account, subdomain: 'fft', name: 'Food for Thought') }
  let!(:account_2) { create(:account, subdomain: 'idhc', name: 'Iglesia Dedios Hermandad Cristiana') }
  let!(:role) { create(:role, name: 'Volunteer', account: account) }
  let!(:person) { create(:person, name: 'Marsh, Kevin', account: account, roles: [role], password: 'testing123') }

  it 'succeeds with correct password to correct domain' do
    visit new_person_session_url(subdomain: account.subdomain)

    sign_in(person, 'testing123')

    expect(page).to have_content('Signed in successfully.')

    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully.')
  end

  it 'fails with incorrect password to correct domain' do
    visit new_person_session_url(subdomain: account.subdomain)

    sign_in(person, 'obviouslybadpassword')
    expect(page).to have_content('Invalid email or password.')
  end

  it 'fails with correct password to incorrect domain' do
    visit new_person_session_url(subdomain: account_2.subdomain)

    sign_in(person, 'testing123')

    expect(page).to have_content('Invalid email or password.')
  end
end

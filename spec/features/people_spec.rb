require 'rails_helper'

feature "Listing people", :type => :feature do
  let!(:account) { create(:account) }
  let!(:account_2) { create(:account, subdomain: 'fft', name: 'Food for Thought') }
  let!(:role) { create(:role, name: 'Volunteer', account: account) }
  let!(:person) { create(:person, name: 'Marsh, Kevin', account: account, roles: [role], password: 'testing123') }
  let!(:person_2) { create(:person, name: 'Smith, Joe', account: account_2, password: 'testing123') }

  scenario "requires login" do
    visit people_url(subdomain: account.subdomain)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario "viewing people" do
    visit people_url(subdomain: account.subdomain)

    sign_in(person, 'testing123')

    expect(page).to have_content 'Marsh, Kevin'
    expect(page).to have_content 'Volunteer'
  end

  scenario "not visible from another account" do
    visit people_url(subdomain: account_2.subdomain)

    sign_in(person_2, 'testing123')

    expect(page).not_to have_content 'Marsh, Kevin'
  end
end

feature "Adding people", :type => :feature do
  let!(:account) { create(:account) }
  let!(:account_2) { create(:account, subdomain: 'fft', name: 'Food for Thought') }
  let!(:role) { create(:role, name: 'Volunteer', account: account) }
  let!(:role_2) { create(:role, name: 'Donor', account: account) }
  let!(:person) { create(:person, name: 'Marsh, Kevin', account: account, roles: [role], password: 'testing123') }
  let!(:person_2) { create(:person, name: 'Smith, Joe', account: account_2, password: 'testing123') }

  scenario "with valid information" do
    visit people_url(subdomain: account.subdomain)

    sign_in(person, 'testing123')

    click_link "New Person"
    fill_in "Name", with: "Marsh, Kevin"
    check "Volunteer"
    click_button 'Save'

    expect(page).to have_content 'Person was successfully created.'
    expect(page).to have_content 'Marsh, Kevin'
    expect(page).to have_content 'Volunteer'
    expect(page).to_not have_content 'Donor'
  end

  scenario "missing name" do
    visit people_url(subdomain: account.subdomain)

    sign_in(person, 'testing123')

    click_link "New Person"
    fill_in "Email", with: "kevin.marsh@gmail.com"
    click_button 'Save'

    expect(page).to have_content 'Please fix the errors below.'
  end
end

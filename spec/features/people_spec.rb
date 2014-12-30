require 'rails_helper'

feature "Listing people", :type => :feature do
  let!(:person) { create(:person, name: 'Marsh, Kevin') }
  let!(:account) { create(:account) }

  scenario "with people already in the database" do
    visit people_url(subdomain: account.subdomain)
    expect(page).to have_content 'Marsh, Kevin'
  end
end

feature "Adding people", :type => :feature do
  let!(:account) { create(:account) }

  scenario "with valid information" do
    visit people_url(subdomain: account.subdomain)
    click_link "New Person"
    fill_in "Name", with: "Marsh, Kevin"
    click_button 'Save'

    expect(page).to have_content 'Person was successfully created.'
    expect(page).to have_content 'Marsh, Kevin'
  end

  scenario "missing name" do
    visit people_url(subdomain: account.subdomain)
    click_link "New Person"
    fill_in "Email", with: "kevin.marsh@gmail.com"
    click_button 'Save'

    expect(page).to have_content 'Please fix the errors below.'
  end
end

module Features
  module SessionHelpers
    def sign_in(person, password)
      fill_in 'Email', with: person.email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end

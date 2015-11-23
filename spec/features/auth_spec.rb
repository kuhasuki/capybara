require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do

    before(:each) do
     visit new_user_url
     fill_in 'Username', :with => "testing_username"
     fill_in 'Password', :with => "capybara"
     click_on "Create User"
    end

    scenario "show username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end

  end

end

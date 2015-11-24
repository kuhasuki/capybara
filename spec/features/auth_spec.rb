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

feature "logging in" do

  let(:user) { FactoryGirl.create(:user) }

  scenario "shows username on the homepage after login" do
   visit new_session_url
   fill_in 'Username', :with => user.username
   fill_in 'Password', :with => "thenews"
   click_on "Sign in"
   expect(page).to have_content "hueylewis"
  end

end

feature "logging out" do
  let(:user) { FactoryGirl.create(:user) }

  scenario "begins with logged out state" do
    visit new_session_url
    expect(page).to have_content "Sign in"
  end

  scenario "doesnt show username on the homepage after logout" do
    visit new_session_url
    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => "thenews"
    click_on "Sign in"
    click_on "Sign out"
    expect(page).not_to have_content "hueylewis"
  end
end

feature "CRUD goals" do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit new_session_url
    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => "thenews"
    click_on "Sign in"
  end

  scenario "show page has goals" do
    expect(page).to have_content "hueylewis's goals"
  end

  # scenario "user can access the create a goal page" do
  #   click_on "Set a New Goal"
  # end

  scenario "goal page has public and private options" do
    click_on "Set a New Goal"
    expect(page).to have_content "Create a New Goal"
    expect(page).to have_select("Goal Type")
  end

  scenario "user can see their newly created goal" do
    click_on "Set a New Goal"
    fill_in "Goal", :with => "Be hip"
    select "Public", :from => "Goal Type"
    click_on "Set Goal"
    expect(page).to have_content "Be hip"
  end

  scenario "user can edit a goal" do
    click_on "Set a New Goal"
    fill_in "Goal", with: "Be hip"
    select "Public", from: "Goal Type"
    click_on "Set Goal"

    click_on "Edit Goal"
    expect(page).to have_content "Update Your Goal"
  end

end

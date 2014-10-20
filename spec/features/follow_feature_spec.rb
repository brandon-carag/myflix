require 'spec_helper'

feature "Social Networking" do
  # TODO: Possible refactor
  # let!(:user1) { Fabricate(:user,password:"password") } 
  # let!(:user2) { Fabricate(:user,password:"password") } 
  # let!(:video) { Fabricate(:video) }
  # let!(:review) { Fabricate(:review, user_id:user2.id, video_id:video.id) }
  before do
  end

  scenario "Follow a Person" do
    user1 = Fabricate(:user,password:"password")
    user2 = Fabricate(:user,password:"password")
    video = Fabricate(:video)
    review = Fabricate(:review, user_id:user2.id, video_id:video.id)

    visit sign_in_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', :with => "password"
    click_button "Sign In"
    find(:xpath, "//a[@href='/videos/1']").click
    click_link user2.full_name
    click_button "Follow"

    expect(page).to have_text(user2.full_name)
  end

  scenario "Unfollow a Person" do
    user1 = Fabricate(:user,password:"password")
    user2 = Fabricate(:user,password:"password")
    video = Fabricate(:video)
    review = Fabricate(:review, user_id:user2.id, video_id:video.id)

    visit sign_in_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', :with => "password"
    click_button "Sign In"
    find(:xpath, "//a[@href='/videos/1']").click
    click_link user2.full_name
    click_button "Follow"
    find(:xpath, "//a[@href='/followings/2']").click

    expect(page).not_to have_text(user2.full_name)
    end
end


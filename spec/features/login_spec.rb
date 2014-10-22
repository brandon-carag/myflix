require 'spec_helper'
require 'pry'

feature "User sign in" do
  scenario "With valid email and password" do
    user = Fabricate(:user,password:"password")

    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', :with => "password"
    click_button "Sign In"

    expect(page).to have_content(user.full_name)
  end
end

feature "Add video to queue" do
  scenario "With valid email and password" do
    video1 = Fabricate(:video)
    video3 = Fabricate(:video)
    video2 = Fabricate(:video)

    sign_in
    find(:xpath, "//a[@href='/videos/1']").click
    click_link "+ My Queue"

    expect(page).to have_text(video1.title)

    click_link video1.title
    
    expect(page).to have_text(video1.title)
    expect(page).not_to have_link("+ My Queue")

    click_link "Movies"
    find(:xpath, "//a[@href='/videos/2']").click
    click_link "+ My Queue"
    click_link "Movies"
    find(:xpath, "//a[@href='/videos/3']").click
    click_link "+ My Queue"

    click_link "My Queue"
    expect(find_field("queue_items[1]").value).to eq("1")
    expect(find_field("queue_items[2]").value).to eq("2")
    expect(find_field("queue_items[3]").value).to eq("3")

    fill_in 'queue_items[1]', with: "3"
    fill_in 'queue_items[2]', with: "2"
    fill_in 'queue_items[3]', with: "1"
    click_button "Update Instant Queue"

    expect(find_field("queue_items[3]").value).to eq("1")
    expect(find_field("queue_items[2]").value).to eq("2")
    expect(find_field("queue_items[1]").value).to eq("3")

  end
end


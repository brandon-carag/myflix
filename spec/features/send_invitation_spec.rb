require 'spec_helper'

feature "Send Invitation" do

  scenario "Sends Invitation to valid email and creates a following" do
    test_user = Fabricate(:user,password: "password")
    sign_in(test_user)

    click_link "Invite a Friend"
    fill_in 'invitation_recipient_name', with: "John Doe"
    fill_in 'invitation_recipient_email', with: "johndoe@email.com"
    fill_in 'invitation_message', with: "Come join MyFlix!"
    click_button "Send Invitation"
    open_email("johndoe@email.com")
    current_email.click_link 'here'
    fill_in 'user_password', with: "password"
    fill_in 'user_full_name', with: "John Doe"
    click_button "Sign Up"

    fill_in 'email', with: "johndoe@email.com"
    fill_in 'password', with: "password"
    click_button "Sign In"
    click_link "Friends"

    expect(page).to have_text(test_user.full_name)
  end

  scenario "Creates a Following for the invitation sender if recipient joins" do
    test_user = Fabricate(:user,password: "password")
    sign_in(test_user)

    click_link "Invite a Friend"
    fill_in 'invitation_recipient_name', with: "John Doe"
    fill_in 'invitation_recipient_email', with: "johndoe@email.com"
    fill_in 'invitation_message', with: "Come join MyFlix!"
    click_button "Send Invitation"
    open_email("johndoe@email.com")
    current_email.click_link 'here'
    fill_in 'user_password', with: "password"
    fill_in 'user_full_name', with: "John Doe"
    click_button "Sign Up"

    fill_in 'email', with: test_user.email
    fill_in 'password', with: "password"
    click_button "Sign In"
    click_link "Friends"

    expect(page).to have_text("John Doe")
  end


end

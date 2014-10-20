require 'spec_helper'

feature "Forgot Password" do
  scenario "User forgets password" do
    clear_emails

    some_user = Fabricate(:user) 
    visit new_password_reset_path 
    fill_in 'email', with: some_user.email 
    click_button "Send Email"
    open_email(some_user.email)
    current_email.click_link 'Reset your password'
    fill_in 'New Password', with: "new_password"
    click_button "Reset Password"

    visit sign_in_path
    fill_in 'email', with: some_user.email
    fill_in 'password', with: "new_password"
    click_button "Sign In"

    expect(page).to have_text("Welcome")

  end
end


def sign_in(user=nil)
  some_user = user || Fabricate(:user,password:"password")
  visit sign_in_path
  fill_in 'Email', with: some_user.email
  fill_in 'Password', :with => "password"
  click_button "Sign In"
end
def sign_in(user=nil)
  some_user = user || Fabricate(:user,password:"password")
  visit sign_in_path
  fill_in 'Email', with: some_user.email
  fill_in 'Password', :with => "password"
  click_button "Sign In"
end

def clear_user_session
  session[:user_id] = nil
end

def redirect_to_sign_in_path
  expect(response).to redirect_to sign_in_path
end

def set_user_session(user=nil)
  the_user = user || Fabricate(:user)
  session[:user_id] = the_user.id
end
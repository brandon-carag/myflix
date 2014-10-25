shared_examples "require_sign_in" do 
  it "redirects to the sign in page" do
    clear_user_session 
    action
    expect(response).to redirect_to sign_in_path 
  end  
end

shared_examples "tokenable" do
  it "generates a random token when the user is created" do
    expect(object.send(token_name)).to be_present
  end
end

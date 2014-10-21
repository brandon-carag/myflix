require 'spec_helper'
require 'shoulda/matchers'

describe Invitation do
  
  it { should validate_presence_of(:recipient_email) }
  it { should validate_presence_of(:recipient_name) }
  it { should validate_presence_of(:message) }

  describe ".generate_invite_token" do
    it "generates an invite token" do
    test_invitation = Fabricate(:invitation)

    test_invitation.generate_invite_token
    expect(test_invitation).to be_truthy
    end
  end

end


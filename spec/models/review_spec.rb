require 'spec_helper'
require 'shoulda/matchers'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }
end
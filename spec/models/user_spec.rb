require 'spec_helper'
require 'shoulda/matchers'

describe User do
  
  it { should have_many(:reviews)}
  it { should have_many(:queue_items)}
  it { should have_many(:followings)}
  it { should have_many(:followers)}

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }

end
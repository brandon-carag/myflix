require 'spec_helper'
require 'shoulda/matchers'

describe Following do
  
it { should belong_to(:follower) }
it { should belong_to(:followed) }

end


require 'spec_helper'
require 'shoulda/matchers'

describe QueueItem do 
it { should belong_to(:video) }
it { should belong_to(:user) }
end  

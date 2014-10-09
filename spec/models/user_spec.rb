require 'spec_helper'

describe User do
   it "has a vaild factory" do 
     create(:user).should be_valid
  end
end

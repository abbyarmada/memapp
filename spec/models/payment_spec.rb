require 'spec_helper'

describe Payment do
  
  
  ########  VALIDATIONS    ######################## 
  it "has a vaild factory" do 
    create(:payment).should be_valid
  end
  it "is invalid without amount" do 
    build(:payment, amount: nil).should_not be_valid
  end
  it "is invalid without date_lodged" do 
    build(:payment, date_lodged: nil).should_not be_valid
  end
  it "is invalid without member_id" do 
     build(:payment, member_id: nil).should_not be_valid
  end
  it "is invalid without privilege_id" do 
    build(:payment, privilege_id: nil).should_not be_valid
  end
  it "is invalid without payment_method_id" do 
    build(:payment, payment_method_id: nil).should_not be_valid
  end
  it "is invalid without paymenttype_id" do 
    build(:payment, paymenttype_id: nil).should_not be_valid
  end
  
  #### valid cases ####
  it "is OK to have a first payment for renewals" do
    build(:payment, paymenttype_id: 4).should be_valid
  end
  
  #### instance tests ############ 
  it "is invalid to have a duplicate paymenttype for renewals" do
    create(:payment)
    build(:payment,privilege_id: 2 ).should_not be_valid
  end
   it "it is invalid to have a final paymenttype without a first payment for renewals" do
     build(:payment, paymenttype_id: 5).should_not be_valid
  end
  it "is OK to have a final paymenttype with a first payment for renewals" do
    create(:payment, paymenttype_id: 4)
    build(:payment, paymenttype_id: 5).should be_valid
  end
end

require 'rails_helper'

describe Payment, :type => :model do
  
########  VALIDATIONS    ######################## 
  it "has a vaild factory" do 
    expect(create(:payment)).to be_valid
  end
  it "is invalid without amount" do 
    expect(build(:payment, amount: nil)).not_to be_valid
  end
  it "is invalid without date_lodged" do 
    expect(build(:payment, date_lodged: nil)).not_to be_valid
  end
  it "is invalid without member_id" do 
     expect(build(:payment, member_id: nil)).not_to be_valid
  end
  it "is invalid without privilege_id" do 
    expect(build(:payment, privilege_id: nil)).not_to be_valid
  end
  it "is invalid without payment_method_id" do 
    expect(build(:payment, payment_method_id: nil)).not_to be_valid
  end
  it "is invalid without paymenttype_id" do 
    expect(build(:payment, paymenttype_id: nil)).not_to be_valid
  end
  
  #### valid cases ####
  it "is OK to have a first payment for renewals" do
    expect(build(:payment, paymenttype_id: 4)).to be_valid
  end
  
  #### instance tests ############ 
  it "is invalid to have a duplicate Renewal payment within a year" do
    create(:payment)
    expect(build(:payment)).not_to be_valid
  end
   it "it is invalid to have a final paymenttype without a first payment for renewals" do
     expect(build(:payment, paymenttype_id: 5)).not_to be_valid
  end
  it "is OK to have a final paymenttype with a first payment for renewals" do
    create(:payment, paymenttype_id: 4)
    expect(build(:payment, paymenttype_id: 5)).to be_valid
  end
  #it "Can return main members person_id"  do
  #   member = create(:member)
  #   person = create(:person)
  #   payment = create(:payment)
  #   expect(payment.main_member.id).to eq(person.id)
  #end
end

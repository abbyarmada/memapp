FactoryGirl.define do
  require 'faker'
factory :payment do |f|
 #   f.association :privilege
 #   f.association :member
    f.privilege_id 1
    f.member_id 1
    f.amount 480
     f.date_lodged "01.01.2014"
##     f.pay_type "crap"
     f.comment "payment"
#     f.privilege_id 1
     f.paymenttype_id 1
     f.payment_method_id 1
  end
end
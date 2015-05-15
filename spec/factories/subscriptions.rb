FactoryGirl.define do
  factory :subscription do
    amount 150.50
    start_date "2014-01-01 00:00:00"
    end_date "2014-12-31 23:59:59"
    privilege_id 1
  end
end

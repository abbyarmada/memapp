FactoryGirl.define do
  require 'faker'
  factory :renewal do |f|
    f.subject "testing"
    f.content "MyText"
    f.delivered_at "2014-11-26 12:34:38"
    f.requested_at "2014-11-26 12:34:38"
  end
end

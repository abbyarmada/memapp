class PaymentMethod < ActiveRecord::Base
  has_one :payment
end

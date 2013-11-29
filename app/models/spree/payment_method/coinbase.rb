module Spree
  class PaymentMethod::Coinbase < PaymentMethod
    preference :api_key, :string, default: nil
    attr_accessible :preferred_api_key
  end
end

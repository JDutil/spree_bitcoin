module Spree
  class PaymentMethod::Coinbase < PaymentMethod
    preference :api_key, :string, default: nil

    # TODO: Rails 4 doesn't like attr_accessible
    attr_accessible :preferred_api_key

    def auto_capture?
      true
    end

    def purchase(amount, source, gateway_options={})
      # TODO: figure out if this method should be doing something else

      success = true
      message = ""
      params = {source: source, gateway_options: gateway_options}
      options = {:fraud_review => nil, :authorization => nil}

      ActiveMerchant::Billing::Response.new(success, message, params, options)
    end
  end
end

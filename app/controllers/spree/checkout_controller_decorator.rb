module Spree
  CheckoutController.class_eval do

    before_filter :redirect_to_coinbase_if_needed, :only => [:update]

    private

    def redirect_to_coinbase_if_needed
      return unless params[:state] == "payment"
      return unless params[:order][:payments_attributes]

      payment_method = Spree::PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
      return unless payment_method.kind_of?(Spree::PaymentMethod::Coinbase)

      redirect_to(spree.coinbase_invoice_path(:payment_method_id => payment_method.id)) and return
    end

  end
end

module Spree
  class CoinbaseController < StoreController

    def invoice
      # items = current_order.line_items.map do |item|
      #   {
      #     :Name => item.product.name,
      #     :Number => item.variant.sku,
      #     :Quantity => item.quantity,
      #     :Amount => {
      #       :currencyID => current_order.currency,
      #       :value => item.price
      #     },
      #     :ItemCategory => "Physical"
      #   }
      # end

      # Because PayPal doesn't accept $0 items at all.
      # See #10
      # https://cms.paypal.com/uk/cgi-bin/?cmd=_render-content&content_ID=developer/e_howto_api_ECCustomizing
      # "It can be a positive or negative value but not zero."
      # items.reject! do |item|
      #   item[:Amount][:value].zero?
      # end
      # pp_request = provider.build_set_express_checkout({
      #   :SetExpressCheckoutRequestDetails => {
      #     :ReturnURL => confirm_paypal_url(:payment_method_id => params[:payment_method_id], :utm_nooverride => 1),
      #     :CancelURL =>  cancel_paypal_url,
      #     :SolutionType => payment_method.preferred_solution.present? ? payment_method.preferred_solution : "Mark",
      #     :LandingPage => payment_method.preferred_landing_page.present? ? payment_method.preferred_landing_page : "Billing",
      #     :cppheaderimage => payment_method.preferred_logourl.present? ? payment_method.preferred_logourl : "",
      #     :PaymentDetails => [payment_details(items)]
      #   }})

      begin
        response = HTTParty.post('https://coinbase.com/api/v1/buttons',
          :body => {
            :button => {
              :callback_url => spree.coinbase_notify_url,
              :custom => current_order.number,
              :description => "#{current_order.line_items.map{|li| li.product.name }.join('\n')}",
              :name => "#{Spree::Config[:site_name]} Order #{current_order.number}",
              :type => 'buy_now',
              :price_string => current_order.total,
              :price_currency_ico => current_currency.iso,
              :include_email => true
            }
          }.to_json,
          :headers => { 'Content-Type' => 'application/json' }
        )
        puts response.body, response.code, response.message, response.headers.inspect
        # 
        response.each do |item|
          puts item.inspect
          puts item['code']
        end
        code = ''
        redirect_to "https://coinbase.com/checkouts/#{code}"
      rescue
        flash[:error] = "Could not connect to Coinbase."
        redirect_to checkout_state_path(:payment)
      end
    end

    private

    def payment_method
      Spree::PaymentMethod.find(params[:payment_method_id])
    end

  end
end

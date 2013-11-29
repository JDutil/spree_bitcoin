module Spree
  class CoinbaseController < StoreController

    def invoice
      # begin
        Rails.logger.debug current_order.inspect
        Rails.logger.debug current_order.total
        Rails.logger.debug({
            :button => {
              :callback_url => spree.coinbase_notify_url,
              :cancel_url => spree.checkout_state_url(:payment),
              :custom => current_order.number,
              :description => "#{current_order.line_items.map{|li| "#{li.quantity} x #{li.product.name} #{Spree::Money.new(li.price)}" }.join('\n')}",
              :name => "#{Spree::Config[:site_name]} Order #{current_order.number}",
              :type => 'buy_now',
              :price => current_order.total.to_s,
              :price_string => current_order.total.to_s,
              :price_currency_ico => current_currency,
              :include_email => true,
              :success_url => spree.order_url(current_order)
            }
          }.to_json)
        response = HTTParty.post("https://coinbase.com/api/v1/buttons?api_key=#{payment_method.preferred_api_key}",
          :body => {
            :button => {
              :callback_url => spree.coinbase_notify_url,
              :cancel_url => spree.checkout_state_url(:payment),
              :custom => current_order.number,
              :description => "#{current_order.line_items.map{|li| "#{li.quantity} x #{li.product.name} #{Spree::Money.new(li.price)}" }.join('\n')}",
              :include_email => true,
              :name => "#{Spree::Config[:site_name]} Order #{current_order.number}",
              :type => 'buy_now',
              :price => current_order.total.to_s,
              :price_currency_ico => current_currency,
              :price_string => current_order.total.to_s,
              :success_url => spree.order_url(current_order)
            }
          }.to_json,
          :headers => { 'Content-Type' => 'application/json' }
        )
        data = response.parsed_response
        Rails.logger.debug data
        if data['success'] == true
          code = data['button']['code']
          redirect_to "https://coinbase.com/checkouts/#{code}"
        else
          flash[:error] = "Coinbase Error: #{data['errors'].join(',')}"
          redirect_to checkout_state_path(:payment)
        end
      # rescue
      #   flash[:error] = "Could not connect to Coinbase."
      #   redirect_to checkout_state_path(:payment)
      # end
    end

    def notify
      Rails.logger.debug params.inspect
    end

    private

    def payment_method
      @payment_method ||= Spree::PaymentMethod.find(params[:payment_method_id])
    end

  end
end

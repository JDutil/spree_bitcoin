class CreateSpreeCoinbasePayments < ActiveRecord::Migration
  def change
    create_table :spree_coinbase_payments do |t|
      t.string :order_number
      t.string :coinbase_submitted_at
      t.string :satoshi
      t.string :coinbase_id
      t.string :coinbase_button_id
      t.string :receive_address
      t.string :transaction_id
      t.string :transaction_hash
      t.string :transaction_confirmations
      t.string :customer_email
      t.datetime :created_at
    end
  end
end

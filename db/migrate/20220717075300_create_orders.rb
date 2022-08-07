class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.timestamps
      t.integer :customer_id, null: false
      t.string :invoice_postalcode, null: false
      t.string :invoice_address, null: false
      t.integer :pay_method, null: false
      t.string :invoice_name, null: false
      t.integer :postage, null: false
      t.integer :billing, null: false
      t.integer :status, null: false, default: 0
    end
  end
end

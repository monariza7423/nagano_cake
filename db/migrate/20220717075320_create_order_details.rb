class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.timestamps
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.string :purcase_price, null: false
      t.string :amount, null: false
      t.integer :product_status, null: false
    end
  end
end

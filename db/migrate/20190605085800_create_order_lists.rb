class CreateOrderLists < ActiveRecord::Migration[5.2]
  def change
    create_table :order_lists do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.integer :unit_sold_price

      t.timestamps
    end
  end
end

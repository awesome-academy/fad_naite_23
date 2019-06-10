class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :status, default: 0
      t.string :receiver_name
      t.string :delivery_address
      t.string :receiver_phone_number

      t.timestamps
    end
  end
end

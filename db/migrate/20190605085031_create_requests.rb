class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :product_name
      t.text :description
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

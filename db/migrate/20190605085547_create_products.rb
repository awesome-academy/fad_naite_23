class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price
      t.integer :type
      t.float :discount

      t.timestamps
    end
  end
end

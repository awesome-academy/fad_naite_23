class AddAverageRatingToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :average_rating, :float, default: 0
  end
end

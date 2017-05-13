class AddCategoryIndexToRestaurants < ActiveRecord::Migration[5.0]
  def change
  	add_reference :restaurants, :category, index:true
  end
end

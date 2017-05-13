class AddRestaurantIndexToMenus < ActiveRecord::Migration[5.0]
  def change
  	add_reference :menus, :restaurant, index: true
  end
end

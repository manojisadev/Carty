class AddRestaurantIndexToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_reference :orders, :restaurant, index: true
  	add_reference :orders, :user, index: true
  end
end

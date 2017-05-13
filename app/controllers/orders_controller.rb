class OrdersController < ApplicationController
	#before_action :set_restaurant
	#before_action :authenticate_user!

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@order = Order.new(restaurant: @restaurant)
		@menus = Menu.where(restaurant_id: @restaurant)
	end 

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		# @menu = Menu.new(menu_params)		
		# @restaurant = Restaurant.find(params[:restaurant_id])
		# @menu.restaurant = @restaurant
		# @menu.save
		# redirect_to @restaurant
		# params['order'].each do| key, value |
		# 	puts key
		# 	puts value
		# end
		# puts "hi";
		@value = 0
		@order = Order.new(order_params)
		params['order'].each do |key,value| 
			if(value.to_i > 0)
				puts key
				puts value
				@menus = Menu.where(id: key)
				puts @menus.inspect
				@orderitem = OrderItem.new()
				@orderitem.menu_id = @menus
				@orderitem.quantity = value
				@orderitem.order_id =  @order
				#puts @orderitem.inspect
				@orderitem.save

			end
		puts @order.inspect	
		end
		@restaurant = Restaurant.find(params[:restaurant_id]) 
	end

	private
		def set_restaurant
			@restaurant = Restaurant.find(params[:restaurant_id]) 
		end
		
		def order_params
			params.require(:order).permit(:total, :active)
		end

		def orderItem_params
			params.require(:orderitem).permit().tap do |whitelisted|
				whitelisted["order"] = params[:order]["order"]
			end
		end


		

end

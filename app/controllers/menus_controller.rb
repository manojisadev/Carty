class MenusController < ApplicationController
	before_action :set_restaurant

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@menu = Menu.new(restaurant: @restaurant)
	end 

	def create
		@menu = Menu.new(menu_params)		
		@restaurant = Restaurant.find(params[:restaurant_id])
		@menu.restaurant = @restaurant
		@menu.save
		redirect_to @restaurant
	end

	def show
		@restaurant = Restaurant.find(params[:id])
		@menus = Menu.where(restaurant_id: @restaurant)
	end



	def edit 
		#@comment = @post.comments.find(params[:id])
		#@restaurant = Restaurant.find(params[:restaurant_id])
		@menu = Menu.find(params[:id])
	end

	def update
		#@restaurant = Restaurant.find(params[:id])
		#@restaurant.update(restaurant_params)
		@menu = Menu.find(params[:id])
		@menu.update(menu_params)
		redirect_to @restaurant
	end

	def destroy
		#@restaurant = Restaurant.find(params[:restaurant_id])
		@menu = Menu.find(params[:id])
		@menu.destroy
		redirect_to @restaurant
	end

	private
		def set_restaurant
			@restaurant = Restaurant.find(params[:restaurant_id]) 
		end
		
		def menu_params
			params.require(:menu).permit(:name, :price)
		end


end

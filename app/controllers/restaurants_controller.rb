class RestaurantsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :new,:edit, :update, :destroy]
	before_action :is_admin?, only: [:edit, :update, :destroy]
	def index

		@restaurants = Restaurant.all
	end

	def new

		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		@restaurant.user_id = current_user.id
		if @restaurant.save
			redirect_to (@restaurant)
		else
			redirect_to (new_restaurant_path) 
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
		@reviews = Review.where(restaurant_id: @restaurant)
		@user = User.all
		if @reviews.blank?
			@avg_rating = 0
		else 
			@avg_rating = @reviews.average(:rating).round(2)
		end

		@hash = Gmaps4rails.build_markers(@restaurant) do |cart, marker|
  	marker.lat cart.latitude
  	marker.lng cart.longitude
  	marker.infowindow cart.name
  	end 

	end
	def sentiment
		@restaurant = Restaurant.find(params[:id])
		@reviews = Review.where(restaurant_id: @restaurant)

	end
		def orders
	end
	def search
		if params[:category].blank?
			@restaurants = Restaurant.all
		else	
			@restaurants = Restaurant.search(params)
		end
	end

	def map
		@restaurants = Restaurant.all

		@hash = Gmaps4rails.build_markers(@restaurants) do |cart, marker|
	  	marker.lat cart.latitude
	  	marker.lng cart.longitude
	  	#marker.infowindow '<a href="/postos/show/#{car.id}>" Go to ... </a>'
	  	marker.infowindow "<a href=#{cart.id}> <h1> #{cart.name}</h1> <br> #{cart.address1
	  	} <br> #{cart.city} <br> #{cart.phone}</a>"
  	end 
  	# @json = @restaurants.to_gmaps4rails do |cart,marker|
  	# 	marker.infowindow render_to_string ()
	end

	def localmap

		visitor_latitude = request.location.latitude
		visitor_longitude = request.location.longitude
		if(visitor_longitude == 0.0 && visitor_latitude == 0.0 ) 
			visitor_latitude = 40.6813424
			visitor_longitude = -73.8530168
		end
			puts visitor_longitude
		@restaurants = Restaurant.near([visitor_latitude, visitor_longitude], 20)

		@hash = Gmaps4rails.build_markers(@restaurants) do |cart, marker|
	  	marker.lat cart.latitude
	  	marker.lng cart.longitude
	  	#marker.infowindow '<a href="/postos/show/#{car.id}>" Go to ... </a>'
	  	marker.infowindow "<a href=#{cart.id}> <h1> #{cart.name}</h1> <br> #{cart.address1
	  	} <br> #{cart.city} <br> #{cart.phone}</a>"
  	end 
  	render :map
	end
	def edit 
		@restaurant = Restaurant.find(params[:id])
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy
		redirect_to root_path
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update(restaurant_params)
		redirect_to @restaurant
	end

		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :category_id, :address1, :address2, :city, :state, :zipcode, :phone, :email, :image)
		end

		def is_admin?
			if !current_user.admin?
				redirect_to root_path
				flash[:danger] = "You aren't authorized to edit or delete."
			end
		end

end

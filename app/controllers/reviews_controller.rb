class ReviewsController < ApplicationController
	before_action :set_restaurant
	before_action :authenticate_user!

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new(restaurant: @restaurant)
	end 

	def create
		
		@review = current_user.reviews.build(review_params)
		@review.restaurant = @restaurant
		@review.save
		redirect_to @restaurant
	end

	def sentiment
		@reviews = Review.find(restaurant_id: @restaurant)
	end

	private
		def set_restaurant
			@restaurant = Restaurant.find(params[:restaurant_id]) 
		end
		
		def review_params
			params.require(:review).permit(:comment, :rating)
		end
		

end

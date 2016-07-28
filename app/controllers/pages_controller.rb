class PagesController < ApplicationController

	def home


	end

	def balance

		@page = "balance"

	end


	def producers

		@producers = User.all

	end


	def profile_page

		@page = "profile"
		
		if params[:username]

			@user = User.find_by_display_name(params[:username])

			unless @user
				redirect_to root_path
			end

			#@last_5_user_tracks = @user.tracks.last(5).reverse

		else

			redirect_to root_path
		end	
	end

	def requests


		@page = "requests"

	end

end

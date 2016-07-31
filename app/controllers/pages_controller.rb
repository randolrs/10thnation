class PagesController < ApplicationController

	def home

		@page = "home"

	end

	def dashboard




	end

	def follow

		if params[:followingID]

			@followingUser = User.where(id: params[:followingID]).first

			if @followingUser

				@existing_following = Following.where(following_id: @followingUser.id, follower_id: current_user.id).first
				
				if @existing_following

					if @existing_following.active

						@existing_following.update(:active => false)

						respond_to do |format|
							format.js { render json: { :status => "success", :now_following => false } , content_type: 'text/json' }
						end
					
					else

						@existing_following.update(:active => true)

						respond_to do |format|
							format.js { render json: { :status => "success", :now_following => true } , content_type: 'text/json' }
						end

					end

				else
		      		@following = Following.new

		      		@following.update(:following_id => params[:followingID], :follower_id => current_user.id, :active => true)

		      		if @following.save

						respond_to do |format|
							format.js { render json: { :status => "success", :now_following => true } , content_type: 'text/json' }
						end

					else

						respond_to do |format|
							format.js { render json: { :status => "failure", :now_following => false } , content_type: 'text/json' }
						end
					end

				end

			else

				respond_to do |format|
						format.js { render json: { :status => "failure", :now_following => false } , content_type: 'text/json' }
				end

			end
		
		end

	end


	def follow_community

		if params[:followingID]

			@followingCommunity = Community.where(id: params[:followingID]).first

			if @followingCommunity

				@existing_following = Following.where(following_id: @followingCommunity.id, follower_id: current_user.id).first
				
				if @existing_following

					if @existing_following.active

						@existing_following.update(:active => false)

						respond_to do |format|
							format.js { render json: { :status => "success", :now_following => false } , content_type: 'text/json' }
						end
					
					else

						@existing_following.update(:active => true)

						respond_to do |format|
							format.js { render json: { :status => "success", :now_following => true } , content_type: 'text/json' }
						end

					end

				else
		      		@following = Following.new

		      		@following.update(:following_id => params[:followingID], :follower_id => current_user.id, :active => true)

		      		if @following.save

						respond_to do |format|
							format.js { render json: { :status => "success", :now_following => true } , content_type: 'text/json' }
						end

					else

						respond_to do |format|
							format.js { render json: { :status => "failure", :now_following => false } , content_type: 'text/json' }
						end
					end

				end

			else

				respond_to do |format|
						format.js { render json: { :status => "failure", :now_following => false } , content_type: 'text/json' }
				end

			end
		
		end

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

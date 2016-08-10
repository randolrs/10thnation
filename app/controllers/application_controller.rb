class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    Stripe.api_key = ENV["stripe_api_key"]

  	protect_from_forgery with: :exception

  	#before_action :new_track_for_form

  	before_action :check_account, if: :user_signed_in?

  	before_action :new_post_for_modal

	before_action :configure_permitted_parameters, if: :devise_controller?

  	protected


	def new_post_for_modal

		@new_post = Post.new

	end


	def check_account
	
		unless current_user.stripe_account_id

			#account = Stripe::Account.create({:country => "US", :managed => true})

			#current_user.update(:stripe_account_id => "")



		end

	end


	def configure_permitted_parameters
	    
	    #registration_params = [:email, :display_name, :first_name, :last_name, :image, :password, :password, :password_confirmation]
	   	
	   	registration_params = [:email, :display_name, :first_name, :last_name, :password, :image, :password, :password_confirmation]
	    
	    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(registration_params) }
	    #devise_parameter_sanitizer.for(:sign_out) { |u| u.permit(registration_params) }
	    #devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(registration_params) }
	    #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(registration_params) }

	    #devise_parameter_sanitizer.for(:sign_up) + registration_params
	    #devise_parameter_sanitizer.for(:sign_in) + registration_params
	    #devise_parameter_sanitizer.for(:account_update) + registration_params

    	devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
    	devise_parameter_sanitizer.permit(:sign_in, keys: registration_params)
    	devise_parameter_sanitizer.permit(:account_update, keys: registration_params)

  	end

  	def after_sign_in_path_for(user)
  		
  		if current_user.communities_array.count == 0

  			default_communities = Array.new

  			default_communities = ["All", "News", "Sports", "Entertainment"]
  			
  			default_communities.each do |community|

  				if Community.exists?(:name => community)
  					
  					@community = Community.where(:name => community).last
	  				
	  				@following = Following.new

					@following.update(:following_id => @community.id, :follower_id => current_user.id, :active => true)

					@following.save

				end

  			end

  		end

  		root_path

	end

  	def after_sign_out_path_for(user)
  		request.referrer
	end


end

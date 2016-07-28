class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    Stripe.api_key = ENV["stripe_api_key"]

  	protect_from_forgery with: :exception

  	#before_action :new_track_for_form

  	before_action :check_account, if: :user_signed_in?

	before_action :configure_permitted_parameters, if: :devise_controller?

  	protected


	#def new_track_for_form

		#@new_track = Track.new

	#end

	def check_account
	
		unless current_user.stripe_account_id

			#account = Stripe::Account.create({:country => "US", :managed => true})

			#current_user.update(:stripe_account_id => "")



		end

	end


	def configure_permitted_parameters
	    
	    registration_params = [:email, :display_name, :first_name, :last_name, :image, :password, :password, :password_confirmation]
	   
    	devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)

  	end
end

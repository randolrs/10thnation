class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	has_attached_file :image, 
		:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"}, 
		:default_url => 'missing_:style.png',
		:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_attached_file :cover_image, 
		:styles => { :large => "194x194#"}, 
		:default_url => 'cover_img_:style.png',
		:s3_protocol => :https

	validates_attachment_content_type :cover_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_many :posts

	def has_cover_image

		if self.cover_image.url == "cover_img_original.png"

			return false
		else

			return true
		end

	end

	def followers

		@following_users = Array.new

		@followings = Following.where(:following_id => self.id, :active => true)
		
		@followings.each do |following|
			
			@user_following = User.where(id: following.follower_id).first
			
			if @user_following 
			
				@following_users << @user_following

			end

		end

		return @following_users

	end

	def followings

		@following_users = Array.new

		@followings = Following.where(:follower_id => self.id, :active => true)
		
		@followings.each do |following|
			
			@user_following = User.where(id: following.follower_id).first
			
			if @user_following 
			
				@following_users << @user_following

			end

		end

		return @following_users

	end

	def is_following(following_id)

		#return true
		@existing_following = Following.where(following_id: following_id, follower_id: self.id, active: true).first
			
		if @existing_following

			
			return true
		
		else
			
			return false

		end

	end

end

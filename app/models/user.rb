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

	has_many :comments

	has_many :post_votes

	has_many :comment_votes

	def has_cover_image

		if self.cover_image.url == "cover_img_original.png"

			return false
		else

			return true
		end

	end


	def hot_posts

		@hot_posts = Post.all.sort_by(&:vote_count)

		return @hot_posts.reverse
	end

	def new_posts

		return Post.all.reverse
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

	def is_following_community(community_id)

		return false
	end

	def is_member_of_community(community_id)

		return false
	end

	def communities_array

		@communities = Array.new

		@followings = Following.where(:follower_id => self.id, :active => true)
		
		@followings.each do |following|
			
			community = Community.where(id: following.following_id).first
			
			if community
			
				@communities << community

			end

		end

		return @communities

	end

	def default_subscriptions




	end

	def has_upvote(post_id)

		return PostVote.exists?(:user_id => self.id, :post_id => post_id, :is_up => true)
	end

	def has_downvote(post_id)

		return PostVote.exists?(:user_id => self.id, :post_id => post_id, :is_down => true)
	end

end

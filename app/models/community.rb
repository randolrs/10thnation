class Community < ActiveRecord::Base

		has_many :posts

		has_attached_file :image, 
		:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"}, 
		:default_url => 'missing_:style.png',
		:s3_protocol => :https

		validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

		def has_cover_image

			if self.cover_image.url == "cover_img_original.png"

				return false
			else

				return true
			end

		end

	def hot_posts

		@hot_posts = self.posts.all.sort_by(&:vote_count)

		return @hot_posts.reverse
	end

	def new_posts

		@new_posts = self.posts.all.reverse

		return @new_posts
	end

	def main

		return Community.find(1)

	end

end

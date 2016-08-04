class Community < ActiveRecord::Base

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

end

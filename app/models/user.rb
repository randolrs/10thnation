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
end

class Post < ActiveRecord::Base

	belongs_to :user

	has_attached_file :image, 
	:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"},
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


end

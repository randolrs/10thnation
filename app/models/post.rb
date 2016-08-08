class Post < ActiveRecord::Base

	belongs_to :user

	has_many :comments

	has_attached_file :image, 
	:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_:style.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def top_level_comments

		return self.comments.where(:parent_comment_id => nil).reverse

	end

end

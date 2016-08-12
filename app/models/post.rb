class Post < ActiveRecord::Base

	belongs_to :user

	belongs_to :community

	has_many :post_votes

	has_many :comments

	has_many :post_click_throughs

	has_many :impressions

	has_attached_file :image, 
	:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_:style.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def top_level_comments

		@top_level_comments_ordered = self.comments.where(:parent_comment_id => nil).sort_by(&:vote_count)

		return @top_level_comments_ordered.reverse

	end

	def vote_count

		up_votes = self.post_votes.where(:is_up => true).count
		down_votes = self.post_votes.where(:is_down => true).count
		calc = up_votes - down_votes
		return calc

	end

	def ctr

		if self.post_click_throughs.count > 0 and self.impressions.count
			
			ctr = (self.post_click_throughs.count.to_f / self.impressions.count.to_f)*100

		else

			ctr = 0
		end

		return ctr.to_i

	end

	def avg_click_through_position

		if self.post_click_throughs.count > 0 and self.post_click_throughs.count > 0

			avg = self.post_click_throughs.sum("position") / self.post_click_throughs.count

		else

			avg = 0
		end

		#avg = self.post_click_throughs.sum("position") / self.post_click_throughs.count

		return avg

	end

end

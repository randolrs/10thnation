class Comment < ActiveRecord::Base

	belongs_to :post, dependent: :destroy

	belongs_to :user

	has_many :comment_votes

	def responses

		return Comment.all.where(:parent_comment_id => self.id).sort_by(&:vote_count).reverse

	end

	def vote_count

		up_votes = self.comment_votes.where(:is_up => true).count
		down_votes = self.comment_votes.where(:is_down => true).count
		calc = up_votes - down_votes
		
		return calc

	end

end

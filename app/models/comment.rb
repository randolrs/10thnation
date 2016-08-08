class Comment < ActiveRecord::Base

	belongs_to :post

	belongs_to :user

	def responses

		return Comment.all.where(:parent_comment_id => self.id)

	end

end

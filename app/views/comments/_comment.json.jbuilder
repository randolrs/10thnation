json.extract! comment, :id, :post_id, :user_id, :comment_text, :parent_comment_id, :score, :created_at, :updated_at
json.url comment_url(comment, format: :json)
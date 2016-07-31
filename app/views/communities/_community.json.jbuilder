json.extract! community, :id, :user_id, :name, :description, :approved, :parent_community_id, :created_at, :updated_at
json.url community_url(community, format: :json)
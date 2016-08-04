class AddUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url, :string
    add_column :posts, :community_id, :integer
  end
end

class AddUrlNameToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :url_name, :string, default: ""
  end
end

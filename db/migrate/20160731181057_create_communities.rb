class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.boolean :approved
      t.integer :parent_community_id

      t.timestamps null: false
    end
  end
end

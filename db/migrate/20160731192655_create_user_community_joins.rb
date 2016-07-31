class CreateUserCommunityJoins < ActiveRecord::Migration
  def change
    create_table :user_community_joins do |t|
      t.integer :user_id
      t.integer :community_id
      t.boolean :active
      t.integer :required_approvals
      t.integer :approvals

      t.timestamps null: false
    end
  end
end

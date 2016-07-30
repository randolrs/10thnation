class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :follower_id
      t.integer :following_id
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end

class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :is_up, default: false
      t.boolean :is_down, default: false

      t.timestamps null: false
    end
  end
end

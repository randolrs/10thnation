class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :comment_text
      t.integer :parent_comment_id
      t.integer :score

      t.timestamps null: false
    end
  end
end

class CreatePostClickThroughs < ActiveRecord::Migration
  def change
    create_table :post_click_throughs do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :position

      t.timestamps null: false
    end
  end
end

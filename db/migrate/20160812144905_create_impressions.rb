class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :position

      t.timestamps null: false
    end
  end
end

class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :text
    add_column :users, :stripe_account_id, :string
  end
end

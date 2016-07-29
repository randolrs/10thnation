class AddAttachmentCoverImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :cover_image
    end
  end

  def self.down
    remove_attachment :users, :cover_image
  end
end

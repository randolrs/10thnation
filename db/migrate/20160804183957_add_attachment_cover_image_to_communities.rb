class AddAttachmentCoverImageToCommunities < ActiveRecord::Migration
  def self.up
    change_table :communities do |t|
      t.attachment :cover_image
    end
  end

  def self.down
    remove_attachment :communities, :cover_image
  end
end

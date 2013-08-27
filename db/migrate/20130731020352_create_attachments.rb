class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :message_id
      t.integer :conversation_id
      t.integer :page_id

      t.string :fbattach_id
      t.string :mime_type
      t.string :name
      t.integer :size

      t.integer :image_width
      t.integer :image_height
      t.string :image_url
      t.string :image_preview_url

      t.timestamps
    end
  end
end

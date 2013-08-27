class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :page_id

      t.string :fbconv_id
      t.datetime :updated_time
      t.string :link

      t.integer :message_count
      t.integer :unread_count

      t.timestamps
    end
  end
end

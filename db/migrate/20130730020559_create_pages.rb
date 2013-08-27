class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :user_id

      t.string :page_id
      t.string :name
      t.string :link
      t.string :category
      t.string :about

      t.string :desc
      t.string :desc_html
      t.string :picture

      t.integer :likes
      t.integer :unread_message_count
      t.integer :unread_notif_count
      t.integer :unseen_message_count

      t.string :access_token

      t.timestamps
    end
  end
end

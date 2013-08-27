class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :page_id

      t.string :fbmsg_id
      t.datetime :created_time

      t.string :read_status
      t.integer :sender_id  # reference: participant

      t.text :content

      t.timestamps
    end
  end
end

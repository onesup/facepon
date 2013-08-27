# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130731020352) do

  create_table "attachments", force: true do |t|
    t.integer  "message_id"
    t.integer  "conversation_id"
    t.integer  "page_id"
    t.string   "fbattach_id"
    t.string   "mime_type"
    t.string   "name"
    t.integer  "size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_url"
    t.string   "image_preview_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.integer  "page_id"
    t.string   "fbconv_id"
    t.datetime "updated_time"
    t.string   "link"
    t.integer  "message_count"
    t.integer  "unread_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "page_id"
    t.string   "fbmsg_id"
    t.datetime "created_time"
    t.string   "read_status"
    t.integer  "sender_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.integer  "user_id"
    t.string   "page_id"
    t.string   "name"
    t.string   "link"
    t.string   "category"
    t.string   "about"
    t.string   "desc"
    t.string   "desc_html"
    t.string   "picture"
    t.integer  "likes"
    t.integer  "unread_message_count"
    t.integer  "unread_notif_count"
    t.integer  "unseen_message_count"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.string   "fb_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "profile_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

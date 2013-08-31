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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130831070402) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
  end

  create_table "interesting_user_posts", :force => true do |t|
    t.string   "instagram_user_id"
    t.string   "media_id"
    t.string   "image_standard"
    t.string   "image_low"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "thumb_image"
  end

  create_table "interesting_users", :force => true do |t|
    t.string   "instagram_user_id"
    t.string   "instagram_profile_picture"
    t.string   "instagram_username"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.integer  "category_type",             :limit => 1, :default => 1
  end

  create_table "sub_categories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "trending_users", :force => true do |t|
    t.string   "instagram_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "profile_image"
    t.text     "bio"
    t.string   "media"
    t.string   "followed_by"
    t.string   "follows"
    t.string   "website"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "trending_users", ["instagram_id"], :name => "index_trending_users_on_instagram_id", :unique => true
  add_index "trending_users", ["username"], :name => "index_trending_users_on_username", :unique => true

  create_table "trendings", :force => true do |t|
    t.string   "instagram_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "profile_image"
    t.text     "bio"
    t.string   "uploads"
    t.string   "followed_by"
    t.string   "follows"
    t.string   "website"
    t.string   "media"
    t.string   "media_id"
    t.string   "media_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "trendings", ["instagram_id"], :name => "index_trendings_on_instagram_id", :unique => true
  add_index "trendings", ["username"], :name => "index_trendings_on_username", :unique => true

  create_table "users", :force => true do |t|
    t.string   "instagram_email"
    t.string   "password"
    t.string   "auth_token"
    t.string   "instagram_id"
    t.string   "instagram_username"
    t.string   "instagram_access_token"
    t.string   "instagram_full_name"
    t.string   "instagram_image"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

end

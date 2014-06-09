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

ActiveRecord::Schema.define(version: 20140531085314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: true do |t|
    t.integer  "volume_number"
    t.string   "cover_url"
    t.string   "book_url"
    t.string   "book_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cartoons", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "picture_url"
    t.string   "path"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_users", force: true do |t|
    t.string   "token"
    t.string   "nickname"
    t.string   "email"
    t.string   "code"
    t.string   "head_icon_url"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jokes", force: true do |t|
    t.text     "content"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jzws", force: true do |t|
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "musics", force: true do |t|
    t.string   "singer"
    t.string   "song"
    t.string   "url"
    t.string   "durl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "identity_user"
    t.string   "nickname"
    t.string   "input_content"
    t.integer  "data_type"
    t.integer  "data_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

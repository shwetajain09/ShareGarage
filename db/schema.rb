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

ActiveRecord::Schema.define(version: 20160215102334) do

  create_table "authors", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "json_details", limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "authors", ["name"], name: "index_authors_on_name", using: :btree

  create_table "authors_books", id: false, force: :cascade do |t|
    t.integer "author_id", limit: 4, null: false
    t.integer "book_id",   limit: 4, null: false
  end

  add_index "authors_books", ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id", using: :btree
  add_index "authors_books", ["book_id", "author_id"], name: "index_authors_books_on_book_id_and_author_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.string   "subtitle",               limit: 255
    t.string   "link",                   limit: 255
    t.text     "description",            limit: 65535
    t.text     "json_details",           limit: 65535
    t.string   "publisher",              limit: 255
    t.date     "published_date"
    t.string   "isbn",                   limit: 255
    t.integer  "page_count",             limit: 4
    t.integer  "language_id",            limit: 4
    t.integer  "count",                  limit: 4
    t.float    "google_provided_rating", limit: 24
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "google_id",              limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "slug",                   limit: 255
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn", using: :btree
  add_index "books", ["language_id"], name: "index_books_on_language_id", using: :btree
  add_index "books", ["publisher"], name: "index_books_on_publisher", using: :btree
  add_index "books", ["subtitle"], name: "index_books_on_subtitle", using: :btree
  add_index "books", ["title"], name: "index_books_on_title", using: :btree

  create_table "books_users", force: :cascade do |t|
    t.integer  "book_id",     limit: 4
    t.integer  "user_id",     limit: 4
    t.boolean  "is_provided"
    t.integer  "count",       limit: 4, default: 1
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "books_users_locations", id: false, force: :cascade do |t|
    t.integer "books_user_id", limit: 4
    t.integer "location_id",   limit: 4
  end

  add_index "books_users_locations", ["books_user_id", "location_id"], name: "by_books_user_and_location", unique: true, using: :btree
  add_index "books_users_locations", ["books_user_id"], name: "index_books_users_locations_on_books_user_id", using: :btree
  add_index "books_users_locations", ["location_id"], name: "index_books_users_locations_on_location_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "country_name", limit: 255
    t.string   "locale",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "parent_id",  limit: 4
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.float    "rating",      limit: 24
    t.float    "credit",      limit: 24, default: 0.0
    t.integer  "location_id", limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tokens", force: :cascade do |t|
    t.string   "redeem_code", limit: 255
    t.boolean  "is_redeemed",             default: false
    t.datetime "valid_til"
    t.integer  "owner",       limit: 4
    t.integer  "receiver_id", limit: 4
    t.integer  "book_id",     limit: 4
    t.float    "credit",      limit: 24
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "book_id",     limit: 4
    t.integer  "receiver_id", limit: 4
    t.integer  "giver_id",    limit: 4
    t.integer  "token_id",    limit: 4
    t.boolean  "is_donated",              default: false
    t.string   "message",     limit: 255
    t.float    "credit",      limit: 24,  default: 0.0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "phone_no",               limit: 8
    t.string   "gender",                 limit: 1
    t.boolean  "show_phone",                         default: true
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,    null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "tokens_count",           limit: 4,   default: 0
    t.string   "slug",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

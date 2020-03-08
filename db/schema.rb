# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_08_103438) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "celeb_known_fors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "celeb_id", null: false
    t.bigint "known_for_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["celeb_id"], name: "index_celeb_known_fors_on_celeb_id"
    t.index ["known_for_id"], name: "index_celeb_known_fors_on_known_for_id"
  end

  create_table "celeb_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "celeb_id", null: false
    t.bigint "croosh_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["celeb_id"], name: "index_celeb_likes_on_celeb_id"
    t.index ["croosh_id"], name: "index_celeb_likes_on_croosh_id"
  end

  create_table "celebs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "nick"
    t.integer "rate_per_croosh"
    t.boolean "ready_to_go_live", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "known_for"
    t.string "password_digest"
  end

  create_table "croosh_updates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "croosh_id", null: false
    t.text "update_text"
    t.index ["croosh_id"], name: "index_croosh_updates_on_croosh_id"
  end

  create_table "crooshes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "celeb_id", null: false
    t.bigint "user_id", null: false
    t.integer "user_likes_count", default: 0, null: false
    t.integer "celeb_likes_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_shares_count", default: 0, null: false
    t.boolean "is_request", default: false, null: false
    t.text "request_text"
    t.date "to_complete_date"
    t.index ["celeb_id"], name: "index_crooshes_on_celeb_id"
    t.index ["user_id"], name: "index_crooshes_on_user_id"
  end

  create_table "known_fors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "otp_authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "phone_number", null: false
    t.string "otp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "succeeded", default: false, null: false
    t.integer "user_id"
  end

  create_table "rm_inputs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "input_text"
    t.string "name", default: "", null: false
    t.bigint "croosh_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["croosh_id"], name: "index_rm_inputs_on_croosh_id"
  end

  create_table "user_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "croosh_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["croosh_id"], name: "index_user_likes_on_croosh_id"
    t.index ["user_id"], name: "index_user_likes_on_user_id"
  end

  create_table "user_shares", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "croosh_id", null: false
    t.integer "num", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["croosh_id"], name: "index_user_shares_on_croosh_id"
    t.index ["user_id"], name: "index_user_shares_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "celeb_known_fors", "celebs"
  add_foreign_key "celeb_known_fors", "known_fors"
  add_foreign_key "celeb_likes", "celebs"
  add_foreign_key "celeb_likes", "crooshes"
  add_foreign_key "croosh_updates", "crooshes"
  add_foreign_key "crooshes", "celebs"
  add_foreign_key "crooshes", "users"
  add_foreign_key "user_likes", "crooshes"
  add_foreign_key "user_likes", "users"
  add_foreign_key "user_shares", "crooshes"
  add_foreign_key "user_shares", "users"
end

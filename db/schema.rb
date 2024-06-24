# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_18_152835) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_company_users", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "password_digest", null: false
    t.integer "status", null: false
    t.string "authentication_code", null: false
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_admin_company_users_on_store_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "login_id", limit: 64, null: false, comment: "ログインID"
    t.string "password_digest", null: false, comment: "パスワードダイジェスト"
    t.integer "status", null: false, comment: "ステータス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login_id"], name: "index_admin_users_on_login_id", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false, comment: "エリア名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city_name"
    t.string "prefecture_code"
  end

  create_table "business_hours", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.string "day_of_week"
    t.time "opening_time"
    t.time "closing_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "opening_time2"
    t.time "closing_time2"
    t.time "opening_time3"
    t.time "closing_time3"
    t.time "last_order_time"
    t.time "last_order_time2"
    t.index ["store_id"], name: "index_business_hours_on_store_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false, comment: "カテゴリー名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "inquiry_type", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "tel", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.string "title"
    t.string "usage_terms"
    t.string "presentation_terms"
    t.string "bikou"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "coupon_type_id"
    t.datetime "expiration_date"
    t.integer "unlimited"
    t.index ["store_id"], name: "index_coupons_on_store_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "image_data", comment: "写真パス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_images_on_post_id"
  end

  create_table "notices", force: :cascade do |t|
    t.integer "kind", comment: "お知らせ種類"
    t.text "content", comment: "お知らせ内容"
    t.text "title", comment: "お知らせタイトル"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false, comment: "投稿のタイトル"
    t.string "content", null: false, comment: "投稿内容"
    t.integer "view_count", null: false, comment: "閲覧回数"
    t.bigint "category_id"
    t.bigint "area_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_posts_on_area_id"
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["store_id"], name: "index_posts_on_store_id"
    t.index ["view_count"], name: "index_posts_on_view_count"
  end

  create_table "store_monthly_post_views", force: :cascade do |t|
    t.integer "view_counts", default: 0, null: false
    t.datetime "view_month", precision: nil, null: false
    t.bigint "post_id", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "store_id", "view_month"], name: "index_store_monthly_post_views_on_post_store_month", unique: true
    t.index ["post_id"], name: "index_store_monthly_post_views_on_post_id"
    t.index ["store_id"], name: "index_store_monthly_post_views_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false, comment: "店舗名"
    t.string "tel", null: false, comment: "電話番号"
    t.string "address", null: false, comment: "住所"
    t.string "access", comment: "徒歩 アクセス方法"
    t.string "access2", comment: "バス アクセス方法"
    t.string "nearest_station", comment: "最寄駅"
    t.string "nearest_station2", comment: "最寄駅 2"
    t.string "sales_time_lanch_weekday", comment: "営業時間 ランチ 平日"
    t.string "sales_time_lanch_holiday", comment: "営業時間 ランチ 土日祝"
    t.string "sales_time_dinner_weekday", comment: "営業時間 ディナー 平日"
    t.string "sales_time_dinner_holiday", comment: "営業時間 ディナー 土日祝"
    t.string "holiday", comment: "定休日"
    t.string "pay_methods", comment: "支払い方法"
    t.string "homepage_url", comment: "ホームページURL"
    t.string "sns_link_tabelog", comment: "食べログリンク"
    t.string "sns_link_twitter", comment: "ツイッターリンク"
    t.string "sns_link_instagram", comment: "インスタグラムリンク"
    t.string "sns_link_facebook", comment: "フェースブックリンク"
    t.string "sns_link_line", comment: "LINEリンク"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_map_url"
    t.integer "sales_flg", default: 1, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_company_users", "stores"
  add_foreign_key "business_hours", "stores"
  add_foreign_key "coupons", "stores"
  add_foreign_key "images", "posts"
  add_foreign_key "posts", "areas"
  add_foreign_key "posts", "categories"
  add_foreign_key "posts", "stores"
  add_foreign_key "store_monthly_post_views", "posts"
  add_foreign_key "store_monthly_post_views", "stores"
end

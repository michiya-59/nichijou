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

ActiveRecord::Schema[7.1].define(version: 2023_10_16_015513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false, comment: "カテゴリー名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.string "image_data", comment: "写真パス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_images_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false, comment: "投稿のタイトル"
    t.string "content", null: false, comment: "投稿内容"
    t.string "top_image", null: false, comment: "写真パス"
    t.integer "view_count", null: false, comment: "閲覧回数"
    t.bigint "category_id"
    t.bigint "area_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_posts_on_area_id"
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["store_id"], name: "index_posts_on_store_id"
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
  end

  add_foreign_key "images", "posts"
  add_foreign_key "posts", "areas"
  add_foreign_key "posts", "categories"
  add_foreign_key "posts", "stores"
end
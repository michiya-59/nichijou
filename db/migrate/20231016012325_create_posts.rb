# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.string :top_image, null: false
      t.integer :view_count, null: false
      t.references :category, foreign_key: true
      t.references :area, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
    execute "COMMENT ON COLUMN posts.title IS '投稿のタイトル'"
    execute "COMMENT ON COLUMN posts.content IS '投稿内容'"
    execute "COMMENT ON COLUMN posts.top_image IS '写真パス'"
    execute "COMMENT ON COLUMN posts.view_count IS '閲覧回数'"
  end
end

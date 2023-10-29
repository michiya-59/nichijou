# frozen_string_literal: true

class CreateNotices < ActiveRecord::Migration[7.1]
  def change
    create_table :notices do |t|
      t.integer :kind
      t.text :content
      t.text :title

      t.timestamps
    end
    execute "COMMENT ON COLUMN notices.kind IS 'お知らせ種類'"
    execute "COMMENT ON COLUMN notices.content IS 'お知らせ内容'"
    execute "COMMENT ON COLUMN notices.title IS 'お知らせタイトル'"
  end
end

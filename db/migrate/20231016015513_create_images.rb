class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.references :post, null: false, foreign_key: true
      t.string :image_data

      t.timestamps
    end
    execute "COMMENT ON COLUMN images.image_data IS '写真パス'"
  end
end

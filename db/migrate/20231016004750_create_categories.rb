class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    execute "COMMENT ON COLUMN categories.name IS 'カテゴリー名'"
  end
end

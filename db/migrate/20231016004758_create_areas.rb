class CreateAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :areas do |t|
      t.string :name, null: false

      t.timestamps
    end
    execute "COMMENT ON COLUMN areas.name IS 'エリア名'"
  end
end

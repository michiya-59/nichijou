class CreateAdminUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_users do |t|
      t.string :login_id, null: false, limit: 64
      t.string :password_digest, null: false
      t.integer :status, null: false

      t.timestamps
    end
    add_index :admin_users, :login_id, unique: true
    execute "COMMENT ON COLUMN admin_users.login_id IS 'ログインID'"
    execute "COMMENT ON COLUMN admin_users.password_digest IS 'パスワードダイジェスト'"
    execute "COMMENT ON COLUMN admin_users.status IS 'ステータス'"
  end
end

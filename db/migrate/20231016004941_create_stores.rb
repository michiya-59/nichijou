class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :tel, null: false
      t.string :address, null: false
      t.string :access
      t.string :access2
      t.string :nearest_station
      t.string :nearest_station2
      t.string :sales_time_lanch_weekday
      t.string :sales_time_lanch_holiday
      t.string :sales_time_dinner_weekday
      t.string :sales_time_dinner_holiday
      t.string :holiday
      t.string :pay_methods
      t.string :homepage_url
      t.string :sns_link_tabelog
      t.string :sns_link_twitter
      t.string :sns_link_instagram
      t.string :sns_link_facebook
      t.string :sns_link_line

      t.timestamps
    end

    execute "COMMENT ON COLUMN stores.name IS '店舗名'"
    execute "COMMENT ON COLUMN stores.tel IS '電話番号'"
    execute "COMMENT ON COLUMN stores.address IS '住所'"
    execute "COMMENT ON COLUMN stores.access IS '徒歩 アクセス方法'"
    execute "COMMENT ON COLUMN stores.access2 IS 'バス アクセス方法'"
    execute "COMMENT ON COLUMN stores.nearest_station IS '最寄駅'"
    execute "COMMENT ON COLUMN stores.nearest_station2 IS '最寄駅 2'"
    execute "COMMENT ON COLUMN stores.sales_time_lanch_weekday IS '営業時間 ランチ 平日'"
    execute "COMMENT ON COLUMN stores.sales_time_lanch_holiday IS '営業時間 ランチ 土日祝'"
    execute "COMMENT ON COLUMN stores.sales_time_dinner_weekday IS '営業時間 ディナー 平日'"
    execute "COMMENT ON COLUMN stores.sales_time_dinner_holiday IS '営業時間 ディナー 土日祝'"
    execute "COMMENT ON COLUMN stores.holiday IS '定休日'"
    execute "COMMENT ON COLUMN stores.pay_methods IS '支払い方法'"
    execute "COMMENT ON COLUMN stores.homepage_url IS 'ホームページURL'"
    execute "COMMENT ON COLUMN stores.sns_link_tabelog IS '食べログリンク'"
    execute "COMMENT ON COLUMN stores.sns_link_twitter IS 'ツイッターリンク'"
    execute "COMMENT ON COLUMN stores.sns_link_instagram IS 'インスタグラムリンク'"
    execute "COMMENT ON COLUMN stores.sns_link_facebook IS 'フェースブックリンク'"
    execute "COMMENT ON COLUMN stores.sns_link_line IS 'LINEリンク'"
  end
end

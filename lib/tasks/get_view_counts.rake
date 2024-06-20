# frozen_string_literal: true

namespace :get_view_counts do
  desc "各投稿の閲覧数をstore_monthly_post_viewsテーブルに保存します"

  task fetch: :environment do
    current_time = Time.zone.now.beginning_of_month

    Post.find_each do |post|
      # 既存のレコードがあるかどうかを確認
      existing_record = StoreMonthlyPostView.find_by(post_id: post.id, store_id: post.store_id, view_month: current_time)

      if existing_record
        # 既存のレコードがある場合は更新する
        existing_record.update(view_counts: post.view_count)
      else
        # store_monthly_post_viewsに保存
        post.store_monthly_post_views.create!(
          view_counts: post.view_count,
          view_month: current_time,
          store_id: post.store_id,
          post_id: post.id
        )
      end

      # view_countをリセット
      post.update(view_count: 0)
    end

    puts "閲覧数がstore_monthly_post_viewsテーブルに正常に登録されました。"
  end
end

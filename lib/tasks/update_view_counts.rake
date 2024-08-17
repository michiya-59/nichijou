# lib/tasks/update_post_views.rake
namespace :posts do
  desc "StoreMonthlyPostViewsのview_countsをPostsテーブルのview_countに加算"
  task update_views: :environment do
    # トランザクションを使用して一貫性を保つ
    ActiveRecord::Base.transaction do
      # 今日の日時を取得
      current_time = Time.current
      # 当月の1日を取得
      start_of_month = current_time.beginning_of_month

      StoreMonthlyPostView.find_each do |store_view|
        # view_monthが当月の1日から現在日時の間かを確認
        if store_view.view_month >= start_of_month && store_view.view_month <= current_time
          post = Post.find_by(id: store_view.post_id)

          if post
            # 正しいカラム名を使用して加算処理
            post.increment!(:view_count, store_view.view_counts)
          end

          puts "ID：#{store_view.post_id}のpostsのview_countが更新されました。"
        else
          puts "ID：#{store_view.post_id}は対象日時ではないので処理をスキップしました。"
        end
      end
    end
  rescue => e
    puts "エラーが発生しました: #{e.message}"
  end
end

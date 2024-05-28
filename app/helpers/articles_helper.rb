# frozen_string_literal: true

module ArticlesHelper
  def multi_searched_links prefecture_name, city_name, category_name
    # 基本のURL
    base_url = "/articles/multi_search?"

    # パンくずリストの要素を格納する配列
    breadcrumbs = []

    # 都道府県が存在する場合
    if prefecture_name.present?
      if city_name.blank? && category_name.blank?
        # 都道府県と市区町村、カテゴリーが存在しない場合、リンク無しで太文字表示
        breadcrumbs << content_tag(:strong, prefecture_name)
      else
        # 都道府県用のURL
        prefecture_query = "#{base_url}prefecture=#{prefecture_name}"
        # リンク付きの都道府県を追加（クラス 'common_a' を付与）
        breadcrumbs << link_to(prefecture_name, prefecture_query, class: "common_a")
      end

      if city_name.present? && category_name.present?
        # 市区町村とカテゴリーを一つの項目として太文字で追加
        breadcrumbs << content_tag(:strong, "#{city_name} #{category_name}")
      elsif city_name.present?
        # 市区町村のみが存在する場合
        breadcrumbs << content_tag(:strong, city_name)
      elsif category_name.present?
        # カテゴリーのみが存在する場合
        breadcrumbs << content_tag(:strong, category_name)
      end
    elsif category_name.present?
      # カテゴリーのみが存在する場合
      breadcrumbs << content_tag(:strong, category_name)
    elsif prefecture_name.blank? && city_name.blank? && category_name.blank?
      # 全ての要素が空の場合、「検索結果一覧」を表示
      breadcrumbs << content_tag(:strong, "検索結果一覧")
    end

    # パンくずリストを " > " で安全に連結して表示
    safe_join(breadcrumbs, " > ")
  end
end

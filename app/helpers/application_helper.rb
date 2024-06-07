# frozen_string_literal: true

module ApplicationHelper
  def active_link_to name, path, options = {}
    class_name = active_class_for_path(path)
    options[:class] = [options[:class], class_name].compact.join(" ")
    link_to(name, path, options)
  end

  def truncate_content content, length, omission: "...."
    return content if content.length <= length

    content.truncate(length, omission:)
  end

  def get_store_name
    store_id = current_admin.store_id
    Store.find(store_id).name
  end

  def get_notice_kind_classname kind
    case kind
    when 1
      "notice"
    when 2
      "release"
    else
      ""
    end
  end

  def get_notice_kind_name kind
    case kind
    when 1
      "お知らせ"
    when 2
      "リリース"
    else
      ""
    end
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def assign_meta_tags options = {}
    defaults = t("meta_tags.defaults")
    options.reverse_merge!(defaults)

    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]

    configs = {
      separator: "|",
      reverse: true,
      site:,
      title:,
      description:,
      keywords:,
      canonical: request.original_url,
      og: {
        type: "article",
        title: title.presence || site,
        description:,
        url: request.original_url,
        site_name: site
      },
      fb: {
        app_id: "*****"
      },
      twitter: {
        site: "@twitter_account",
        card: "summary"
      }
    }

    set_meta_tags(configs)
  end

  def seo_title name, type = nil
    if type.blank?
      if name.blank?
        "おすすめのお店を紹介!飲食店・美容院・整体・小売り店などの特集! "
      else
        "おすすめの#{name}を紹介! #{name}特集! "
      end
    elsif type == "recommend"
      "飲食店・美容院・整体・小売り店のおすすめを紹介!"
    elsif type == "news"
      "飲食店・美容院・整体・小売り店の新着を紹介!"
    elsif type == "area"
      "#{name}でおすすめの飲食店・美容院・整体・小売り店の新着を紹介!"
    end
  end

  def seo_title_multisearch prefecture_name, city_name, category_name
    if prefecture_name.present? && city_name.present? && category_name.present?
      "#{prefecture_name} #{city_name}でおすすめな#{category_name}"
    elsif prefecture_name.present? && city_name.present?
      "#{prefecture_name} #{city_name}でおすすめなお店"
    elsif prefecture_name.present? && category_name.present?
      "#{prefecture_name}でおすすめな#{category_name}"
    elsif prefecture_name.present?
      "#{prefecture_name}でおすすめなお店"
    elsif category_name.present?
      "全国でおすすめな#{category_name}"
    else
      "おすすめのお店を紹介!飲食店・美容院・整体・小売り店などの特集! "
    end
  end

  def seo_description name, _type = nil
    "おすすめの#{name}のお店を紹介!地元の人が知っている街の名店・知ってるとちょっと鼻が高くなる良いお店を掲載中!"
  end

  def remove_city_ward_county address
    address.gsub(/市|区|郡/, "") if address.present?
  end

  def json_ld article
    image_url = if article.top_image.attached?
                  rails_blob_url(article.top_image, disposition: "attachment", host: "nichijou-portal.com")
                else
                  "" # 画像がない場合のデフォルト値
                end

    JSON.generate({"@context": "http://schema.org",
                   "@type": "Article",
                   name: article&.store&.name.to_s&.delete("\t"),
                   image: image_url.to_s&.delete("\t"),
                   address: {
                     "@type": "PostalAddress",
                     streetAddress: article&.store&.address.to_s&.delete("\t"),
                     addressLocality: article&.area&.name.to_s&.delete("\t"),
                     addressRegion: article&.area&.city_name.to_s&.delete("\t")
                   },
                   telephone: article&.store&.tel.to_s&.delete("\t"),
                   servesCuisine: article&.category&.name.to_s&.delete("\t")})
  end

  private

  def active_class_for_path path
    request_path = request.path
    base_path = URI.parse(path).path # pathから基本部分を取得

    if request_path.include?("admin_coupons")
      if base_path.include?("admin_stores")
        "active_link"
      else
        ""
      end
    else
      request_path.start_with?(base_path) ? "active_link" : ""
    end
  end

  def get_coupon_expiration_data coupon_info
    if coupon_info&.expiration_date.present?
      coupon_info.expiration_date.strftime("%Y年%m月%d日")
    elsif coupon_info&.unlimited.present?
      "無期限"
    end
  end
end

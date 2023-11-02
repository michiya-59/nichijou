# frozen_string_literal: true

module ApplicationHelper
  def active_link_to name, path, options = {}
    class_name = active_class_for_path(path)
    options[:class] = [options[:class], class_name].compact.join(" ")
    link_to(name, path, options)
  end

  def truncate_content(content, length, omission: '....')
    return content if content.length <= length

    content.truncate(length, omission: omission)
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


  private

  def active_class_for_path path
    request_path = request.path
    base_path = URI.parse(path).path # pathから基本部分を取得

    request_path.start_with?(base_path) ? "active_link" : ""
  end
end

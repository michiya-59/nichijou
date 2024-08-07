# frozen_string_literal: true

# lib/line_notifier.rb
require "net/http"
require "uri"
require "json"

module LineNotifier
  LINE_NOTIFY_TOKEN = ENV.fetch("LINE_NOTIFY_TOKEN", nil)
  LINE_NOTIFY_URL = "https://notify-api.line.me/api/notify"

  def self.notify error
    return unless Rails.env.production? # 本番環境のみ実行

    message = format_message(error)
    uri = URI.parse(LINE_NOTIFY_URL)
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{LINE_NOTIFY_TOKEN}"
    request.set_form_data(message:)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    handle_response(response)
  end

  def self.format_message error
    backtrace_info = error.backtrace_locations&.first
    location = if backtrace_info
                 "#{backtrace_info.path}　#{backtrace_info.lineno}行目"
               else
                 "バックトレース情報なし"
               end

    <<~MESSAGE
      エラーが発生しました:
      #{error.message}

      発生場所:
      #{location}

      発生時刻:
      #{Time.current.strftime('%Y/%m/%d %H:%M:%S')}

      バックトレースの先頭10行:
      #{error.backtrace.take(10).join("\n")}
    MESSAGE
  end

  def self.notify_batch_result message
    entryline_notify_token = ENV.fetch("LINE_NOTIFY_BATCH", nil)
    # return unless Rails.env.production? # 本番環境のみ実行

    send_message = if message[:error].present?
                     format_bacth_error_message message
                   else
                     format_batch_message message
                   end
    uri = URI.parse(LINE_NOTIFY_URL)
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{entryline_notify_token}"
    request.set_form_data(message: send_message)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    handle_response(response)
  end

  def self.format_batch_message message
    <<~MESSAGE
      #{message[:batch_name]}

      #{message[:result]}

      バッチ処理時刻：
      #{Time.current.strftime('%Y/%m/%d %H:%M:%S')}
    MESSAGE
  end

  def self.format_bacth_error_message error_in_message
    backtrace_info = error_in_message[:error]&.backtrace_locations&.first
    location = if backtrace_info
                 "#{backtrace_info.path}　#{backtrace_info.lineno}行目"
               else
                 "バックトレース情報なし"
               end

    <<~MESSAGE
      #{error_in_message[:batch_name]} #{error_in_message[:result]}
      #{error_in_message[:error]}

      エラー発生場所:
      #{location}

      エラー発生時刻:
      #{Time.current.strftime('%Y/%m/%d %H:%M:%S')}
    MESSAGE
  end

  def self.handle_response response
    case response
    when Net::HTTPSuccess, Net::HTTPRedirection
      JSON.parse(response.body)
    else
      response.value
    end
  end
end

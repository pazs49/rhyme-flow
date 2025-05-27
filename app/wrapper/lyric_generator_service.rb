require "net/http"
require "uri"
require "json"

class LyricGeneratorService
  BASE_URL = ENV["DEEPSEEK_BASE_URL"]
  API_KEY = ENV["DEEPSEEK_API_KEY"]
  MODEL = "deepseek-chat"

  def initialize(user_prompt:, system_prompt:)
    @user_prompt = user_prompt
    @system_prompt = system_prompt
  end

  def generate
    response = post_request
    return nil unless response["choices"].present?

    raw_content = response["choices"][0]["message"]["content"]
    parsed_json = parse_json_content(raw_content)
    parsed_json
  rescue => e
    Rails.logger.error("LyricsGeneratorService Error: #{e.message}")
    nil
  end

  private

  def post_request
    uri = URI("#{BASE_URL}/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{API_KEY}"
    }

    body = {
      model: MODEL,
      messages: [
        { role: "system", content: @system_prompt },
        { role: "user", content: @user_prompt }
      ],
      stream: false
    }

    response = http.post(uri.path, body.to_json, headers)
    JSON.parse(response.body)
  end

  def parse_json_content(content)
    cleaned = content.gsub(/\A```json\s*|\s*```\z/, "")
    JSON.parse(cleaned)
  end
end

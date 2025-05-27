require "net/http"
require "uri"
require "json"

class LyricGeneratorService
  def initialize(prompt)
    @prompt = prompt.presence || "Write song lyrics."
  end

  def call
    uri = URI("#{ENV['DEEPSEEK_BASE_URL']}/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV['DEEPSEEK_API_KEY']}"
    }

    body = {
      model: "deepseek-chat",
      messages: [
        { role: "system", content: "You are a helpful songwriting assistant. When a user provides details, you generate lyrics and return only a JSON object with the keys: title, genre, mood, and lyrics. Do not return anything else and don't change the title, mood, or genre! If there are minor wrong spelling, correct them but never change the title! You can capitalize the first letter of each word of the title but never change the title!" },
        { role: "user", content: @prompt }
      ],
      stream: false
    }

    response = http.post(uri.path, body.to_json, headers)
    parsed = JSON.parse(response.body)

    parsed.dig("choices", 0, "message", "content")
  rescue => e
    Rails.logger.error("LyricGeneratorService Error: #{e.message}")
    nil
  end
end

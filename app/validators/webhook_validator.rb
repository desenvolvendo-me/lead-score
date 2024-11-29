class WebhookValidator
  def self.valid?(url)
    uri = URI.parse(url)
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump({ "test": "webhook_validation" })

    begin
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end

      response.code.to_i == 200
    rescue => e
      puts "Error validating webhook: #{e.message}"
      false
    end
  end
end

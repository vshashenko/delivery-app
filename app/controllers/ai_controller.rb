class AiController < ApplicationController
  require "net/http"
  require "uri"
  require "json"

  def parse_filter_query
    user_query = params[:text]

    if user_query.nil? || user_query.strip.empty?
      redirect_to deliveries_path
      return
    end

    api_key = ENV["OPENAI_API_KEY"]

    uri = URI.parse("https://api.openai.com/v1/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{api_key}"
    }

    request_body = {
      model: "gpt-4o-mini",
      store: true,
      messages: [
        { role: "system", content: "You have a table for deliveries with columns 'pickup_location', 'delivery_location', 'weight', 'distance', 'cost', 'driver_name'. When I tell you a phrase, you parse it and reply which parts of the phrase fit the columns. Answer in the format 'pickup_location=<value>&pickup_location=<value>&weight=<value>&distance=<value>&cost=<value>&driver_name=<value>'. If you didn't recognize a part of the phase for any column, use value 'none'." },
        { role: "user", content: user_query }
      ],
      max_tokens: 50
    }.to_json

    request = Net::HTTP::Post.new(uri.path, headers)
    request.body = request_body

    response = http.request(request)

    response_data = JSON.parse(response.body)
    gptResponse = response_data["choices"][0]["message"]["content"]
    puts "gptResponse=", gptResponse

    # postprocess gpt response
    if gptResponse == "none"
      deliveries_query = nil
    else
      deliveries_query = gptResponse.gsub("=none", "=").gsub("_location", "_address")
    end

    if deliveries_query.blank?
      deliveries_query = ""
    else
      deliveries_query = "?" + deliveries_query
    end

    redirect_to deliveries_path + deliveries_query
  end
end

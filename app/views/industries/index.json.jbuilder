json.array!(@industries) do |industry|
  json.extract! industry, :name
  json.url industry_url(industry, format: :json)
end

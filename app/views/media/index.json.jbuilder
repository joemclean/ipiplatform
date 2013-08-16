json.array!(@media) do |medium|
  json.extract! medium, :name
  json.url medium_url(medium, format: :json)
end

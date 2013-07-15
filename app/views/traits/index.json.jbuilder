json.array!(@traits) do |trait|
  json.extract! trait, :name, :description
  json.url trait_url(trait, format: :json)
end

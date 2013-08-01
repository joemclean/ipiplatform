json.array!(@traits) do |trait|
  json.extract! trait, :name, :description, :full_trait_description
  json.url trait_url(trait, format: :json)
end

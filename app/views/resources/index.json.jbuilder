json.array!(@resources) do |resource|
  json.extract! resource, :name, :link, :description
  json.url resource_url(resource, format: :json)
end

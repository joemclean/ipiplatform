json.array!(@colors) do |color|
  json.extract! color, :name, :description, :full_color_description
  json.url color_url(color, format: :json)
end

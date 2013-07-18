json.array!(@suggestions) do |suggestion|
  json.extract! suggestion, :author, :thoughts
  json.url suggestion_url(suggestion, format: :json)
end

json.array!(@formats) do |format|
  json.extract! format, :medium_id, :format_type_id
  json.url format_url(format, format: :json)
end

json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :user_id, :resource_id
  json.url bookmark_url(bookmark, format: :json)
end

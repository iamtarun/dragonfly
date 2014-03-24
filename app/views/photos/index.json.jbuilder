json.array!(@photos) do |photo|
  json.extract! photo, :id, :image_uid, :image_name
  json.url photo_url(photo, format: :json)
end

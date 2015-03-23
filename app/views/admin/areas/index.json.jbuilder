json.array!(@areas) do |area|
  json.extract! area, :id, :nombre
  json.url area_url(area, format: :json)
end

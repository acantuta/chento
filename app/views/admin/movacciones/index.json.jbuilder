json.array!(@admin_movacciones) do |admin_movaccion|
  json.extract! admin_movaccion, :id, :nombre
  json.url admin_movaccion_url(admin_movaccion, format: :json)
end

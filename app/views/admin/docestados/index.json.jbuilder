json.array!(@admin_docestados) do |admin_docestado|
  json.extract! admin_docestado, :id, :nombre
  json.url admin_docestado_url(admin_docestado, format: :json)
end

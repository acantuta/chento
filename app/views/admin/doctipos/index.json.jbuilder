json.array!(@admin_doctipos) do |admin_doctipo|
  json.extract! admin_doctipo, :id, :nombre
  json.url admin_doctipo_url(admin_doctipo, format: :json)
end

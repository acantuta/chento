json.array!(@documentos) do |documento|
  json.extract! documento, :id, :doctipo_id, :docestado_id, :nro, :folios, :asunto, :remitente, :cod_remitente, :ambiente
  json.url documento_url(documento, format: :json)
end

class CreateDocumentos < ActiveRecord::Migration
  def change
    create_table :documentos do |t|
      t.references :doctipo, index: true
      t.references :docestado, index: true
      t.string :nro
      t.string :folios
      t.string :asunto
      t.string :remitente
      t.string :cod_remitente
      t.string :ambiente

      t.timestamps null: false
    end
    add_foreign_key :documentos, :doctipos
    add_foreign_key :documentos, :docestados
  end
end

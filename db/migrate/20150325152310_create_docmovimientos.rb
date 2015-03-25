class CreateDocmovimientos < ActiveRecord::Migration
  def change
    create_table :docmovimientos do |t|
      t.integer :area_fuente_id
      t.integer :area_destino_id
      t.references :movaccion, index: true
      t.references :documento, index: true
      t.boolean :recibido
    end
    add_foreign_key :docmovimientos, :movacciones
    add_foreign_key :docmovimientos, :documentos
    add_index :docmovimientos, :area_fuente_id
    add_index :docmovimientos, :area_destino_id
  end
end

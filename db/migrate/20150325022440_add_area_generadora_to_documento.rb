class AddAreaGeneradoraToDocumento < ActiveRecord::Migration
  def change
    add_column :documentos, :area_generadora_id, :int
    add_index :documentos, :area_generadora_id
  end
end

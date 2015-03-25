class AddEstadoToDocumento < ActiveRecord::Migration
  def change
    add_column :documentos, :estado, :string
  end
end

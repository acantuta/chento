class AddDestinatarioToDocumento < ActiveRecord::Migration
  def change
    add_column :documentos, :destinatario, :string
  end
end

class AddUserToDocumentos < ActiveRecord::Migration
  def change
    add_reference :documentos, :user, index: true
    add_foreign_key :documentos, :users
  end
end

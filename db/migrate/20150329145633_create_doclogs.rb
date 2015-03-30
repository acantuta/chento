class CreateDoclogs < ActiveRecord::Migration
  def change
    create_table :doclogs do |t|
      t.references :documento, index: true
      t.string :contenido

      t.timestamps null: false
    end
    add_foreign_key :doclogs, :documentos
  end
end

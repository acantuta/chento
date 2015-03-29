class CreateDocreferencias < ActiveRecord::Migration
  def change
    create_table :docreferencias do |t|
      t.integer :documento_padre_id
      t.integer :documento_hijo_id

      t.timestamps null: false
    end
  end
end

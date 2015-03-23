class CreateUserasignaciones < ActiveRecord::Migration
  def change
    create_table :userasignaciones do |t|
      t.references :user, index: true
      t.references :area, index: true
      t.boolean :es_jefe

      t.timestamps null: false
    end
    add_foreign_key :userasignaciones, :users
    add_foreign_key :userasignaciones, :areas
  end
end

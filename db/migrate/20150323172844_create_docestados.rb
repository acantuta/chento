class CreateDocestados < ActiveRecord::Migration
  def change
    create_table :docestados do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end

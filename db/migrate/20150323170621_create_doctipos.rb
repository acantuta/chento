class CreateDoctipos < ActiveRecord::Migration
  def change
    create_table :doctipos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end

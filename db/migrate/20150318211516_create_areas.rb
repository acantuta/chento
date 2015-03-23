class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end

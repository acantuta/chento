class CreateMovacciones < ActiveRecord::Migration
  def change
    create_table :movacciones do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end

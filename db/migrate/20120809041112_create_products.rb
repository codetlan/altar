class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.decimal :price
      t.text :poem

      t.timestamps
    end
  end
end

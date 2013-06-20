class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :address
      t.string :video

      t.timestamps
    end
  end
end

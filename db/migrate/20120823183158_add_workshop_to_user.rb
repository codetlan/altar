class AddWorkshopToUser < ActiveRecord::Migration
  def change
    add_column :users, :workshop_id, :integer
  end
end

class AddImageNameToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :wall, :string
    add_column :workshops, :name, :string
  end
end

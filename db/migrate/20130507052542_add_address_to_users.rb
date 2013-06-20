class AddAddressToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :address, :text
  end

  def down
  	remove_column :users, :address
  end
end

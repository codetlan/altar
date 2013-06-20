class AddCategoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer
  end
  def down
    remove_column :products, :category_id
  end  
end

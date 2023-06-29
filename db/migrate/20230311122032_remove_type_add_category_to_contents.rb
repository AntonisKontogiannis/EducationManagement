class RemoveTypeAddCategoryToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :category, :string
    remove_column :contents, :type
  end
end

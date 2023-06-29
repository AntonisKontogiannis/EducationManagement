class ChangeContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :file, :string
    add_column :contents, :description, :string
    remove_column :contents, :category
  end
end

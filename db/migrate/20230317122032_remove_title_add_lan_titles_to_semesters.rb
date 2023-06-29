class RemoveTitleAddLanTitlesToSemesters < ActiveRecord::Migration[6.1]
  def change
    add_column :semesters, :gr_title, :string
    add_column :semesters, :en_title, :string
    remove_column :semesters, :title
  end
end

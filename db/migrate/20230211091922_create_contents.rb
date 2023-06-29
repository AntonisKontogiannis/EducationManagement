class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.integer :subject_id
      t.string :type
      t.string :url
      t.string :category

      t.timestamps
    end
  end
end

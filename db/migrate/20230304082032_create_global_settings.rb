class CreateGlobalSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :global_settings do |t|
      t.string :title
      t.string :value

      t.timestamps
    end
  end
end

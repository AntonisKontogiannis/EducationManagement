class CreateSubjectAttends < ActiveRecord::Migration[6.1]
  def change
    create_table :subject_attends do |t|
      t.string :user_id
      t.string :subject_id

      t.timestamps
    end
  end
end

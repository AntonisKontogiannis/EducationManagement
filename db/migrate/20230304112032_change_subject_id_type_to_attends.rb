class ChangeSubjectIdTypeToAttends < ActiveRecord::Migration[6.1]
  def change
    change_table :subject_attends do |t|
      t.change :subject_id, :string
    end
  end
end

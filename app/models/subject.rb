class Subject < ApplicationRecord
    belongs_to :semester
    has_many :contents, dependent: :destroy
    has_many :subject_attends, dependent: :destroy
    has_many :users, through: :subject_attends
    validates :title, presence: true, length: { minimum: 2, maximum: 100}, uniqueness: true

    def professors
        if not self.subject_attends.nil?
            user_ids = self.subject_attends.pluck(:user_id)
            users = User.where(id: user_ids, role: "Professor")
            return users
        end
    end

    def students
        if not self.subject_attends.nil?
            user_ids = self.subject_attends.pluck(:user_id)
            users = User.where(id: user_ids, role: "Student")
            return users
        end
    end

    def students_size
        if not self.subject_attends.nil?
            user_ids = self.subject_attends.pluck(:user_id)
            return User.where(id: user_ids, role: "Student").size
        end
    end
end

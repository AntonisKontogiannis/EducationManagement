class User < ApplicationRecord
    has_many :subject_attends, dependent: :destroy
    has_many :subjects, through: :subject_attends
    validates :first_name, presence: true,   
                        length: { minimum: 3, maximum: 25}   
    validates :last_name, presence: true,   
                        length: { minimum: 3, maximum: 25} 
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
                      uniqueness: { case_sensitive: false },  
                      length: { maximum: 125 },
                      format: { with: VALID_EMAIL_REGEX }
    has_one_attached :avatar
    has_secure_password

    def full_name
        "#{self.first_name } " + "#{self.last_name}"
    end

    def subjects
        ids = self.subject_attends.pluck(:subject_id)
        Subject.where(id: ids)
    end
end

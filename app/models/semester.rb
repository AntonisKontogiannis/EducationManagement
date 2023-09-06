class Semester < ApplicationRecord
    has_many :subjects, dependent: :destroy
    validates :en_title, presence: true, length: { minimum: 5, maximum: 100}, uniqueness: true
    validates :gr_title, presence: true, length: { minimum: 5, maximum: 100}, uniqueness: true
end

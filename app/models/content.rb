class Content < ApplicationRecord
    belongs_to :subject
    validates :title, presence: true, length: { minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 10000}, uniqueness: true
    VALID_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63}(:[0-9]{1,5})?(\/.*)?\z/ix
    validates :url, length: { minimum: 5 }, format: { with: VALID_URL_REGEX }, allow_blank: true
    has_one_attached :file
    has_one_attached :image

    def category
        result = []
        if self.image.attached?
            result.append("Image")
        end
        if self.file.attached?
            result.append("File")
        end
        if not self.url.blank?
            result.append("Link")
        end
        return result.join(", ")
    end
end

class Post < ApplicationRecord
    validates :title, presence: :true
    validates :description, presence: :true

    has_many :post_categories
    has_many :categories, through: :post_category
    has_many :feedbacks
    belongs_to :user

    has_one_attached :post_image
end

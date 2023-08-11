class Category < ApplicationRecord
    validates :title, presence: :true, uniqueness: :true, exclusion: [nil]
    validates :description, presence: :true, exclusion: [nil]

    has_many :post, through: :post_categories
end

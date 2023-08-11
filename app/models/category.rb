class Category < ApplicationRecord
    validates :title, presence: :true, uniqueness: :true, exclusion: [nil]
    validates :description, presence: :true, exclusion: [nil]

    has_many :posts, through: :post_category
end

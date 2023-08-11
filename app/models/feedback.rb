class Feedback < ApplicationRecord
    validates :like, inclusion: [false, true], exclusion: [nil]
    
    belongs_to :user
    belongs_to :post
end

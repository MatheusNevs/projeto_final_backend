class AddPostIdToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_reference :feedbacks, :post, null: false, foreign_key: true
  end
end

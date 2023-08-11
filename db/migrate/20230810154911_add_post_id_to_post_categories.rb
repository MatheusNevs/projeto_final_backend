class AddPostIdToPostCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :post_categories, :post, null: false, foreign_key: true
  end
end

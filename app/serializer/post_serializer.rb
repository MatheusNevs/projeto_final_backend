class PostSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers
    attributes :title, :description, :user, :post_image_url, :id, :feedbacks, :categories

    def post_image_url
        rails_blob_path(object.post_image, only_path: true) if object.post_image.attached?
    end

    def user
        User.find(object.user_id).name + " " + User.find(object.user_id).last_name
    end

    def categories
        postcategories = PostCategory.select { |postcategory| postcategory.post_id == object.id }
        categories = []
        postcategories.each do |postcategory|
          category = Category.find(postcategory.category_id)
          categories.append(category.title)
        end
        categories
    end

    def feedbacks
        feedbacks = Feedback.select {|feedback| feedback.post_id == object.id}
        return feedbacks
    end
end
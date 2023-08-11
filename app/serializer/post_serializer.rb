class PostSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers
    attributes :title, :description, :user, :post_image_url, :id, :feedbacks, :categories

    def post_picture_url
        rails_blob_path(object.post_image, only_path: true) if object.profile_picture.attached?
    end

    def user
        User.find(object.user_id).name + " " + User.find(object.user_id).last_name
    end

end
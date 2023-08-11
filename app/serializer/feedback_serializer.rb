class FeedbackSerializer < Panko::Serializer
    attributes :id, :like, :comment, :post_id, :user_picture_url
    
    def user_picture_url()
        user = User.find(object.user_id)
        return rails_blob_path(user.profile_picture, only_path: true) if user.profile_picture.attached?
    end



end
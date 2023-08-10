class UserSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers
    attributes :name,:last_name, :email, :is_admin, :authentication_token, :profile_picture_url, :description

    def profile_picture_url
        rails_blob_path(object.profile_picture, only_path: true) if object.profile_picture.attached?
    end
end
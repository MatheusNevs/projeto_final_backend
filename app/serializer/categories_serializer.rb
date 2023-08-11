class CategorySerializer < Panko::Serializer
    attributes :title, :description, :id, :posts

    def posts
        array = []
        object.posts.each do |post|
            array.append {"title": post.title, "post_image": post.post_image_url}
        end
        array
    end
end
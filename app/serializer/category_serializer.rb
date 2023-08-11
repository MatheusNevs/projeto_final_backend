class CategorySerializer < Panko::Serializer
    include Rails.application.routes.url_helpers
    attributes :title, :description, :id, :posts
    
    def post_image_url(post)
      rails_blob_path(post.post_image, only_path: true) if post.post_image.attached?
    end

    def posts
        postcategories = PostCategory.select { |postcategory| postcategory.category_id == object.id }
        posts = []
        postcategories.each do |postcategory|
          post = Post.find(postcategory.post_id)
          posts.append({id: post.id, title:post.title, post_image_url: post_image_url(post)})
        end
        return posts
      end  

end
require 'rails_helper'

RSpec.describe "Posts", type: :request do
  
  let(:user_params) do
    attributes_for(:user)
  end
  
  let(:user) {create(:user, is_admin: false,  email: 'teste1@gmail.com')}
  
  let(:authentication_params) {{
    'X-User-Email': user.email,
    'X-User-Token': user.authentication_token
    }}
    
  let(:admin_user) {create(:user, is_admin: true, email: 'teste2@gmail.com')}
  let(:admin_authentication_params) {
    {
      'X-User-Email': admin_user.email,
      'X-User-Token': admin_user.authentication_token
    }
  }
  let(:post) {create(:post, user_id: admin_user.id)}
  let(:post_params) {attributes_for(:post, user_id: admin_user.id)}

  describe "POST /create" do
    context " when params are ok" do
      it "http status should be created" do
        post "/api/posts/create", params: post_params, headers:admin_authentication_params
        expect(response).to have_http_status(:created)
      end
    end

    context " when params aren't ok" do
      it "http status should be bad request" do
        post_params = nil
        post "/api/posts/create", params: post_params, headers: admin_authentication_params
        expect(response).to have_http_status(:bad_request)
      end

      it "http status should be unauthorized" do
        post "/api/posts/create", params: post_params, headers: authentication_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /update/:id" do
    context " when params are ok" do
      it "http status should be ok" do
        patch "/api/posts/update/#{post.id}", params: {post: post_params}, headers: admin_authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context " when params aren't ok" do
      it "new title with nil value should return http status bad_request" do
        patch "/api/posts/update/#{post.id}", params: {post: {title: nil}}, headers: admin_authentication_params
        expect(response).to have_http_status(:bad_request)
      end

      it "try to get a non existing post should return http status not_found" do
        patch "/api/posts/update/-1", params: {post: post_params}, headers: admin_authentication_params
        expect(response).to have_http_status(:not_found)
      end
      
      it " try to update a post being a non admin user should return unauthorized" do
        patch "/api/posts/update/#{post.id}", params: {post: post_params}, headers: authentication_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end


  describe "DELETE /delete/:id" do
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/posts/delete/#{post.id}", headers: admin_authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete non existing post should return http status not_found" do
        delete "/api/posts/delete/-1", headers: admin_authentication_params
        expect(response).to have_http_status(:not_found)
      end

      it "try to delete a post being a non admin user should return unauthorized" do
        delete "/api/posts/delete/#{post.id}", headers: authentication_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /index" do
    POSTS_NUMBER = 20
    before do
      for i in 1..POSTS_NUMBER
        create(:post, title: "teste #{i}", user_id: admin_user.id)
      end
    end

    context "not paginated" do
      before do
        get '/api/posts'
      end

      it "should return all categories in body" do
        expect(JSON.parse(response.body).size).to eq(POSTS_NUMBER)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /show/:id" do
    context "when params are ok" do
      it "try to get a post being a non admin user should return http status ok" do
        get "/api/posts/#{post.id}", headers: authentication_params
        expect(response).to have_http_status(:ok)
      end

      it "try to get a post being an admin user should return http status ok" do
        get "/api/posts/#{post.id}", headers: admin_authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to show non existing post should return http status not_found" do
        get "/api/posts/-1", headers: admin_authentication_params
        expect(response).to have_http_status(:not_found)
      end
    end
  end


end
require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:category) {create(:category)}
  let(:category_params) {attributes_for(:category)}

  let(:user) {create(:user)}
  
  let(:authentication_params) {{
    'X-User-Email': user.email,
    'X-User-Token': user.authentication_token
  }}

  let(:admin_user) {create(:user, is_admin: true)}

  let(:admin_authentication_params) {
    {
      'X-User-Email': admin_user.email,
      'X-User-Token': admin_user.authentication_token
    }
  }

  describe "POST /create" do
    context " when params are ok" do
      it "http status should be created" do
        post "/api/categories/create", params: {category: category_params}, headers: admin_authentication_params
        expect(response).to have_http_status(:created)
      end
    end

    context " when params aren't ok" do
      it "nill values should return http status bad request" do
        category_params = nil
        post "/api/categories/create", params: {category: category_params}, headers: admin_authentication_params
        expect(response).to have_http_status(:bad_request)
      end
      
      it "create category with existing values should return http status bad request" do
        post "/api/categories/create", params: {category: category_params}, headers: admin_authentication_params
        post "/api/categories/create", params: {category: category_params}, headers: admin_authentication_params  
        expect(response).to have_http_status(:bad_request)
      end

      it "try to create a category with a non admin user should return unauthorized " do
        post "/api/categories/create", params: {category: category_params}, headers: authentication_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /update/:id" do
    context " when params are ok" do
      it "http status should be ok" do
        patch "/api/categories/update/#{category.id}", params: {category: category_params}, headers: admin_authentication_params
        expect(response).to have_http_status(:ok)
      end
    end
    
    context " when params aren't ok" do
      let(:category2) {create(:category, title: 'teste2')}
      let(:category_params_nil) {attributes_for(:category, title:nil)}

      it "new title with nil value should return http status bad_request" do
        patch "/api/categories/update/#{category.id}", params: {category: category_params_nil}, headers: admin_authentication_params
        expect(response).to have_http_status(:bad_request)
      end

      it "if new title already exists it returns http status bad_request" do
        patch "/api/categories/update/#{category.id}", params: {title: category2.title}, headers: admin_authentication_params
        expect(response).to have_http_status(:bad_request)
      end
      
      it "try to update non existing category should return http status not_found" do
        patch "/api/categories/update/-1", params: {category: category_params}, headers: admin_authentication_params
        expect(response).to have_http_status(:not_found)
      end

      it "try to update a category with a non admin user should return unauthorized" do
        patch "/api/categories/update/#{category.id}", params: {category: category_params}, headers: authentication_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end


  describe "DELETE /delete/:id" do
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/categories/delete/#{category.id}", headers: admin_authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete non existing category should return http status not_found" do
        delete "/api/categories/delete/-1", headers: admin_authentication_params
        expect(response).to have_http_status(:not_found)
      end

      it " try to delete a category with a non admin user should return http status unauthorized" do
        delete "/api/categories/delete/#{category.id}", headers: authentication_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /index" do
    CATEGORIES_NUMBER = 20
    before do
      for i in 1..CATEGORIES_NUMBER
        create(:category, title: "teste #{i}")
      end
    end

    context "not paginated" do
      before do
        get '/api/categories'
      end

      it "should return all categories in body" do
        expect(JSON.parse(response.body).size).to eq(CATEGORIES_NUMBER)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /show/:id" do
    context "when params are ok" do
      it "http status should be ok" do
        get "/api/categories/#{category.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to show non existing category should return http status not_found" do
        get "/api/categories/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end


end
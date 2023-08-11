require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user_params) do
    attributes_for(:user)
  end

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
        post "/api/users/create", params: {user: user_params}
        expect(response).to have_http_status(:created)
      end
    end

    context " when params aren't ok" do
      user_params = nil
      it "http status should be bad request" do
        post "/api/users/create", params: {user: user_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context " when given params already exists" do
      it "http status should be bad request" do
        post "/api/users/create", params: {user: user_params}
        post "/api/users/create", params: {user: user_params}  
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "PATCH /update" do
    context " when params are ok" do
      it "http status should be ok" do
        patch "/api/users/update/", params: {user: {name: 'testeteste'}}, headers: authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context " when new name is nil" do
      it "http status should be bad_request" do
        patch "/api/users/update/", params: {user: {name: nil}}, headers: authentication_params
        expect(response).to have_http_status(:bad_request)
      end
    end

    context " when new email already exists" do
      let(:user1) {create(:user, email:'teste1@gmail.com')}
      it "http status should be bad_request" do
        patch "/api/users/update/", params: {user: {email: user1.email}}, headers: authentication_params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "DELETE /delete/" do
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/users/delete/", params: {user: admin_authentication_params}, headers: admin_authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete a user being a non admin user should return http status unauthorized" do
        delete "/api/users/delete/", params: {user: user_params}, headers: authentication_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /index" do
    USERS_NUMBER = 20
    before do
      for i in 1..USERS_NUMBER
        create(:user, email: "teste#{i}@gmail.com")
      end
    end

    context "not paginated" do
      before do
        get '/api/users/', headers: admin_authentication_params
      end

      it "should return all users in body" do
        expect(JSON.parse(response.body).size).to eq(USERS_NUMBER + 1)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /show/" do
    context "when params are ok" do
      it "http status should be ok" do
        get "/api/users/show", headers: authentication_params
        expect(response).to have_http_status(:ok)
      end
      
      it " login with an user must return, when requested, informations about the same one" do
        get "/api/users/show", headers: authentication_params
        expect(User.find(user.id).email).to eq(user.email)
      end
    
    end    
  end
end
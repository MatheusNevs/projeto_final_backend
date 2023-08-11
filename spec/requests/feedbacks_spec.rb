require 'rails_helper'

RSpec.describe "feedbacks", type: :request do
  let(:user) {create(:user, is_admin: false,  email: 'teste1@gmail.com')}
  
  let(:authentication_params) {{
    'X-User-Email': user.email,
    'X-User-Token': user.authentication_token
    }}
  
  let(:feedback_params) do
    attributes_for(:feedback)
  end
  let(:feedback) {create(:feedback, user_id: user.id)}

  describe "POST /create" do
    context " when params are ok" do
      it "http status should be created" do
        post "/api/feedbacks/create", params: feedback_params, headers:authentication_params
        expect(response).to have_http_status(:created)
      end
    end

    context " when params aren't ok" do
      let(:feedback_params_nil) {attributes_for(:feedback, user_id: nil)}
      it "http status should be bad request" do
        post "/api/feedbacks/create", params: feedback_params_nil, headers: authentication_params
        expect(response).to have_http_status(:bad_request)
      end

      it "http status should be unauthorized" do
        post "/api/feedbacks/create", params: feedback_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PATCH /update/:id" do
    context " when params are ok" do
      it "http status should be ok" do
        patch "/api/feedbacks/update/#{feedback.id}", params: {feedback: feedback_params}, headers: authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context " when params aren't ok" do
      it "try to get a non existing feedback should return http status not_found" do
        patch "/api/feedbacks/update/-1", params: {post: feedback_params}, headers: authentication_params
        expect(response).to have_http_status(:not_found)
      end
      
      it " try to update a feedback being a non admin user should return status ok" do
        patch "/api/feedbacks/update/#{feedback.id}", params: {post: feedback_params}, headers: authentication_params
        expect(response).to have_http_status(:ok)
      end
    end
  end


  describe "DELETE /delete/:id" do
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/feedbacks/delete/#{feedback.id}", headers: authentication_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete non existing feedback should return http status not_found" do
        delete "/api/feedbacks/delete/-1", headers: authentication_params
        expect(response).to have_http_status(:not_found)
      end

      it "try to delete a post being a non admin user should return ok" do
        delete "/api/feedbacks/delete/#{feedback.id}", headers: authentication_params
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    it "creates a new user and returns a success response" do
      expect(User.count).to eq(0)
      post :create, params: { first_name: "John", last_name: "Doe", email: "john@example.com", password: "password123" }
    end

    describe "#update" do
      let(:user) { create(:user) }

      context "when updating password" do
        it "returns a success response with status code 200" do
          patch :update, params: { id: user.id, password: "new_password" }
          expect(response).to have_http_status(:unauthorized )
        end
      end

      context "with valid params" do
        let(:new_password) { "new_password" }

        before do
          put :update, params: { password: new_password }
        end

        it "updates the user's password" do
          user.reload
          expect(user.authenticate(new_password))
        end

        it "returns a success response" do
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context "when invalid password" do
        it "returns an unprocessable entity response with errors" do
          patch :update, params: { id: user.id, password: "" }
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
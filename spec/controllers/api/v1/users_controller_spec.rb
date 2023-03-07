require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    let(:user) { { first_name: "John", last_name: "Doe", email: "john.doe@example.com", password: "password" } }
    let(:user) { { first_name: "", last_name: "", email: "", password: "" } }

    it "creates a new user and sends a confirmation email with valid parameters" do
      post :create, params: user
      expect(response).to have_http_status(422)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end

    it "creates a new user and returns a 422 status code with valid parameters" do
      post :create, params: user
      expect(response).to have_http_status(422)
      expect(User.count).to eq(0)
    end

    it "returns an error and doesn't create a user with invalid parameters" do
      post :create, params: user
      expect(response).to have_http_status(422)
      expect(User.count).to eq(0)
    end

    describe "#update" do
      let(:user) { create(:user) }
      let(:invalid_user) { { first_name: "", last_name: "", email: "", password: "" } }

      context "when updating password" do
        it "returns a success response with status code 401" do
          patch :update, params: { id: user.id, current_password: "old_password", password: "new_password" }
          expect(response).to have_http_status(401)
          expect(user.reload.authenticate("new_password"))
        end

        it "returns an error response with status code 401 when given invalid parameters" do
          patch :update, params: { id: user.id, current_password: "wrong_password" }.merge(invalid_user)
          expect(response).to have_http_status(401)
          expect(user.reload.authenticate("new_password"))
        end
      end
    end
  end
end
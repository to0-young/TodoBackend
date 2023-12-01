require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    let(:valid_user_params) { { first_name: "John", last_name: "Doe", email: "john.doe@example.com", password: "password" } }
    let(:invalid_user_params) { { first_name: "John", last_name: "Doe", email: "", password: "password" } }

    it "creates a new user with valid params" do
      expect(User.count).to eq(0)
      post :create, params: { user: valid_user_params }
      expect(response).to have_http_status(201)
      expect(User.count).to eq(1)
    end

    it "returns unprocessable entity with invalid params" do
      post :create, params: { user: invalid_user_params }
      expect(response).to have_http_status(422)
      expect(json[:errors]).not_to be_empty
    end
  end

  describe "#update" do
    let(:user) { create(:user, email_confirmed: false) }
    let(:session) { create(:session, user_id: user.id) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "with valid params" do
      it "updates the user and returns ok status" do
        expect(user.email_confirmed).to eq(false)
        patch :update, params: { user: { email_confirmed: true } }
        expect(response).to have_http_status(200)
        user.reload
        expect(user.email_confirmed).to eq(true)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity status" do
        patch :update, params: { user: { password: "rr", password_confirmation: "dd" } }
        expect(response).to have_http_status(422)
        expect(json[:errors][:password_confirmation]).not_to be_empty
      end
    end

    context "when unauthenticated" do
      it "returns unauthorized status" do
        allow(controller).to receive(:current_user)
        patch :update, params: { user: { password: "" } }
        expect(response).to have_http_status(401)
      end
    end
  end
end

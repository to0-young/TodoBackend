require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    let(:user) { { first_name: "", last_name: "", email: "", password: "" } }

    context "with valid parameters" do
      it "creates a new user and sends a confirmation email" do
        expect(User.count).to eq(0)
        expect { post :create, params: user }.to change(User, :count).by(0)
        expect(response).to have_http_status(401)
        expect(ActionMailer::Base.deliveries.count)
      end
    end

    context "with invalid parameters" do
      it "does not create a new user and returns an error response" do
        expect(User.count).to eq(0)
        expect { post :create, params: user }.not_to change(User, :count)
        expect(response).to have_http_status(401)
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end


  describe "#update" do
    let(:user) { create(:user) }

    context "when updating password" do
      it "returns a success response with status code 200" do
        patch :update, params: { id: user.id, password: "new_password" }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with valid params" do
      let(:new_password) { "new_password" }

      before do
        put :update, params: { password: new_password }
      end

      it "updates the users password" do
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


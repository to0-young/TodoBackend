require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    let(:user) { { first_name: "John", last_name: "Doe", email: "john.doe@example.com", password: "password" } }
    let(:user) { { first_name: "", last_name: "", email: "", password: "" } }

    it "when validation error" do
      post :create, params: user
      expect(response).to have_http_status(422)
      expect(User.count).to eq(0)
    end

    it "creates a 200 OK status" do
      expect(response).to have_http_status(200)
    end
  end

    describe "#update" do
      let(:user) { create(:user) }

      it "returns a success response with status code 422" do
        patch :update, params: { id: user.id,  password: "weak" }
        expect(response).to have_http_status(422)
      end


      it "updates a 200 OK status" do
          expect(response).to have_http_status(200)
        end
      end
    end

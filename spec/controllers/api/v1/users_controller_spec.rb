require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    it "creates a new user and returns a success response" do
      expect(User.count).to eq(0)
      post :create, params: { first_name: "John", last_name: "Doe", email: "john@example.com", password: "password123" }
      expect(User.count).to eq(1)
      expect(response).to have_http_status(:created)
    end
  end
end

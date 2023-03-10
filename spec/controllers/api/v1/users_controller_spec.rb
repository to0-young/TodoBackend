require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#create" do
    let(:user) { { first_name: "John", last_name: "Doe", email: "john.doe@example.com", password: "password" } }

    it "when users created" do
      post :create, params: user
      expect(response).to have_http_status(201)
    end
    
  end

  describe "#update" do
    let(:user) { create(:user, email_confirmed: false) }
    let(:session) { create(:session, user_id: user.id) }

    before do
      allow(controller).to receive(:current_session).and_return(session)
    end

    context "when validation ok" do
      it "when 200 ok status" do
        expect(user.email_confirmed).to eq(false)
        patch :update, params: { id: user.id, email_confirmed: true }
        expect(response).to have_http_status(200)
        user.reload
        expect(user.email_confirmed).to eq(true)
      end
    end

    context "when validation error" do
      it "when 422 status" do
        patch :update, params: { id: user.id, password: "rr", password_confirmation: "dd" }
        expect(response).to have_http_status(422)
        expect(json[:errors][:password_confirmation]).not_to be_empty
      end

      context "when unauthenticated" do
        it "when 401 status" do
          allow(controller).to receive(:current_session)  # це мок сесії
          patch :update, params: { id: user.id, password: "" }
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end

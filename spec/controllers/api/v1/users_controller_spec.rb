require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # describe "#create" do
  #   let(:user) { { first_name: "John", last_name: "Doe", email: "john.doe@example.com", password: "password" } }
  #
  #   it "when validation error" do
  #     post :create, params: user
  #     expect(response).to have_http_status(422)
  #   end
  # end

  describe "#update" do
    let(:user) { create(:user, email_confirmed: false ) }
    let(:session) { create(:session, user_id: user.id )}

    before do
      allow(controller).to receive(:current_session).and_return(session)
    end

    it "when 200 ok status" do
      expect(user.email_confirmed).to eq(false)
      patch :update, params: { id: user.id,  email_confirmed: true  }
      expect(response).to have_http_status(200)
      user.reload
      expect(user.email_confirmed).to eq(true)
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  describe "GET index" do
    let(:session) { create(:session) }
    let(:task) { create(:task, user_id: session.user_id) }

    it 'when success' do
      allow(subject).to receive(:current_session).and_return(session)
      task
      get :index
      expect(response).to have_http_status(200)
      expect(json.length).to be(1)
      expect(json[0][:id]).to be(task.id)
    end

    it "when unauthorized" do
      get :index
      expect(response).to have_http_status(401)
    end
  end
end

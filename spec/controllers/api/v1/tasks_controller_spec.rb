require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  describe "GET index" do
    let(:session) { create(:session) }
    let(:user) { create(:user) }
    let!(:task) { create(:task, user_id: session.user_id) }

    before do
      allow(controller).to receive(:current_session).and_return(session)
    end

    it 'when success' do
      allow(subject).to receive(:current_session).and_return(session)
      get :index
      expect(response).to have_http_status(200)
      expect(json[:tasks].length).to be(1)
      expect(json[:tasks][0][:id]).to be(task.id)
    end

    it "when unauthorized" do
      allow(controller).to receive(:current_session).and_return(nil)
      get :index
      expect(response).to have_http_status(401)
    end

    it "returns the task when it exists" do
      get :show, params: { id: task.id }
      expect(response).to have_http_status(:ok)
      expect(json[:id]).to eq(task.id)
    end

    before { get :show, params: { id: task.id } }

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns JSON data for the task' do
      json_data = JSON.parse(response.body)
      expect(json_data['id']).to eq(task.id)
      expect(json_data['title']).to eq(task.title)
    end
  end
end

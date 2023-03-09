require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  describe "#index" do
    let(:session) { create(:session) }
    let(:user) { create(:user) }
    let!(:task) { create(:task, user_id: session.user_id) }

    before do
      allow(controller).to receive(:current_session).and_return(session)
    end

    it 'when success' do
      get :index
      allow(subject).to receive(:current_session)
      expect(response).to have_http_status(200)
      expect(json[:tasks].length).to be(1)
      expect(json[:tasks][0][:id]).to be(task.id)
    end

    it "when unauthorized" do
      allow(controller).to receive(:current_session)
      get :index
      expect(response).to have_http_status(401)
    end

    describe "#show" do
      it "returns the task when it exists" do
        get :show, params: { id: task.id }
        expect(response).to have_http_status(200)
        expect(json[:id]).to eq(task.id)
      end

      it 'returns a success response' do
        get :show, params: { id: task.id }
        expect(response).to have_http_status(200)
      end

      it 'returns JSON data for the task' do
        get :show, params: { id: task.id }
        json_data = JSON.parse(response.body)
        expect(json_data['id']).to eq(task.id)
        expect(json_data['title']).to eq(task.title)
      end
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new task" do
        expect {
          post :create, params: { title: "Title", priority: "number", description: "Description", due_date: Time.now }
        }.to change(Task, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end

    context "with invalid params" do
      it "returns error messages" do
        post :create, params: { title: "", priority: "number", description: "Description", due_date: Time.now }
        expect(response).to have_http_status(401)
        json_response = JSON.parse(response.body)
        expect(json_response["errors"])
      end
    end

    describe '#update' do
      let(:task) { create(:task) }
      let(:invalid_task) { { title: "", priority: "", description: "", due_date: Time.now } }

      context "with valid params" do
        it "updates the task" do
          patch :update, params: { id: task.id, task: { title: "task", priority: "number", description: "Description", due_date: Time.now } }
          expect(response).to have_http_status(401)
        end
      end

      context "with invalid params" do
        it "returns an error message" do
          patch :update, params: { id: task.id, task: { title: "", priority: "", description: "", due_date: Time.now } }
          expect(response).to have_http_status(401)
          json_response = JSON.parse(response.body)
          expect(json_response["errors"])
        end
      end
    end
  end
end


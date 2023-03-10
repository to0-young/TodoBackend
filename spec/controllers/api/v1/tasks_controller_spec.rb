require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  describe "#index" do
    let(:session) { create(:session) }
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
  end


  describe "#create" do
    context "when unauthenticated" do
      let!(:session) { create(:session) }

      it "creates a new task" do
        expect {
          post :create, params: { title: "Title", priority: "number", description: "Description", due_date: Time.now }
        }.to change(Task, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end


    describe '#update' do
      let(:session) { create(:session) }
      let(:user) { create(:user) }
      let(:task) { create(:task) }

      before do
        allow(controller).to receive(:current_session).and_return(session)
      end

      context "when validation ok" do
        it "updates the task" do
          patch :update, params: { id: task.id, task: { title: "task555", priority: 1, user_id: user.id } }
          expect(response).to have_http_status(200)
        end
      end

      context "when validation error" do
        it "returns an error message" do
          patch :update, params: { id: task.id, task: { title: "", priority: "", description: "", due_date: Time.now } }
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end


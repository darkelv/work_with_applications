require 'rails_helper'

RSpec.describe UserRequestsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_request) { create(:user_request, user: user) }

  before { login(user) }

  describe 'GET#Index' do
    let(:user_requests) { create_list(:user_request, 3) }

    before { get :index }

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

    before { get :show, params: { id: user_request.id } }
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'save a user_request in the database' do
        expect { post :create, params: { user_request: attributes_for(:user_request) } }.to change(UserRequest, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the user_request' do
        expect { post :create, params: { user_request: attributes_for(:user_request, :invalid) } }.to_not change(UserRequest, :count)
      end
      it 're-renders new view' do
        post :create, params: { user_request: attributes_for(:user_request, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATH #update' do
    context 'with valid attributes' do
      it 'changes user_request attributes' do
        patch :update, params: { id: user_request, user_request: { title: 'new title', body: 'new body'} }

        user_request.reload
        expect(user_request.title).to eq 'new title'
        expect(user_request.body).to eq 'new body'
      end

      it 'redirect update user_request' do
        patch :update, params: { id: user_request, user_request: attributes_for(:user_request) }
        expect(response).to redirect_to user_request
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: user_request, user_request: attributes_for(:user_request, :invalid) } }

      it 'does not change user_request' do
        user_request.reload

        expect(user_request.title).to eq 'MyString'
        expect(user_request.body).to eq 'MyText'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_request) { create(:user_request) }

    it 'delete the question' do
      expect { delete :destroy, params: { id: user_request } }.to change(UserRequest, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: user_request }
      expect(response).to redirect_to user_requests_path
    end
  end
end

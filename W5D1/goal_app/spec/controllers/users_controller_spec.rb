require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it "renders the new users page" do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the presence of username and password' do
        post :create, params: { user: { username: '', password: '' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it 'redirects to the user\'s show page' do
        post :create, params: { user: { username: 'name', password: 'password' } }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

  describe 'GET #show' do
    it "renders the users page" do
      get :show, params: { id: 1 }
      expect(response).to render_template('show')
      expect(response).to have_http_status(200)
    end
  end

end

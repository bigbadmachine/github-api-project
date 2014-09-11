require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  let!(:github_auth) { FactoryGirl.create(:github_auth, id: 12345) }

  context 'POST #create' do
    it 'sets the current_user and redirects to search page' do
      request.env['omniauth.auth'] = github_auth
      post :create
      expect(controller.send(:current_user).uid).to eq 12345
      expect(response).to redirect_to '/search'
    end
  end

  context 'DELETE #destroy' do
    it 'clears current_user and redirects to home page' do
      delete :destroy
      expect(controller.send(:current_user)).to be_nil
      expect(response).to redirect_to '/'
    end
  end

end

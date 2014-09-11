require 'rails_helper'

RSpec.describe SearchController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user, oauth_token: "702fdd0b0b9d7d6ecb62b6f0dad0bbf519ba3c51") }
  before { controller.send(:auto_login, user) }

  context 'GET #search' do
    it 'does nothing if no search term' do
      get :search
      expect(assigns(:searched)).to eq false
    end

    it 'performs a search to Github API and receives results' do
      get :search, q: "bigbadmachine"
      expect(assigns(:searched)).to eq true
			expect(assigns(:results)).to_not be_empty
    end

    it 'filters search by language' do
      get :search, q: "bigbadmachine", l: "php"
      expect(assigns(:results)).to be_empty
    end
  end

end

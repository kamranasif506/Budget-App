require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'GET #index' do
    it 'renders the index template' do
      get root_path
      expect(response).to be_successful
    end
  end
end

# spec/requests/categories_spec.rb

require 'rails_helper'

RSpec.describe '/categories', type: :request do
  let(:user) { User.create(email: 'new@example.com', name: 'Example Name', password: 'password123') }
 
  let(:valid_attributes) do
    file = Tempfile.new(['example_image', '.png'])
    icon = fixture_file_upload(file.path, 'image/png')
    {
      name: 'test1',
      icon: icon,
      author_id: user.id # Corrected from `author`
    }
  end

  let(:invalid_attributes) do
    {
      name: 'test2',
      author_id: user.id # Corrected from `author`
    }
  end

  before(:each) do
    login_as(user, scope: :user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Category.create! valid_attributes
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post categories_url, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the home page' do
        post categories_url, params: { category: valid_attributes }
        expect(response).to redirect_to(categories_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post categories_url, params: { category: invalid_attributes }
        end.to change(Category, :count).by(0)
      end

    end
  end
end

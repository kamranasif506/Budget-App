# spec/controllers/records_controller_spec.rb

require 'rails_helper'
RSpec.describe '/foods', type: :request do
  let(:file) { Tempfile.new(['example_image', '.png']) }
  let(:icon) { fixture_file_upload(file.path, 'image/png') }
  let(:user) { User.create!(name: 'John Doe', email: 'testing@gmail.com', password: 'f4k3p455w0rd') }
  let(:category) { Category.create(name: 'Example Category', icon:, author: user) }

  before(:each) do
    login_as(user, scope: :user)
  end

  describe 'GET #new' do
    it 'renders the new Records template' do
      get category_records_path(category)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new record' do
      expect do
        post category_records_path(category), params: { record: { name: 'Example Record', amount: 100 } }
      end.to change(Record, :count).by(1)
    end

    it 'redirects to the index page' do
      post category_records_path(category), params: { record: { name: 'Example Record', amount: 100 } }
      expect(response).to redirect_to(category_records_path(category))
    end
  end
end

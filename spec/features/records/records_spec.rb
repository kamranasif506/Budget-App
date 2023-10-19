require 'rails_helper'

RSpec.feature 'Records show', type: :feature do
  let(:user) { User.create!(name: 'John', email: 'john@example.com', password: 'password') }

  before(:each) do
    login_as(user, scope: :user)
    @category = Category.create!(name: 'Example Category', author: user) do |category|
      category.icon.attach(io: File.open('app/assets/images/avatar.jpg'), filename: 'icon.png', content_type: 'image/png')
    end
    @record = Record.create!(name: 'Example Record', amount: 50, author: user)
    RecordItem.create(record: @record, category_id: @category.id)
    visit category_records_path(@category)
  end

  scenario 'display record name' do
    expect(page).to have_content('Example Record')
  end

  scenario 'display record amount' do
    expect(page).to have_content('$50.00')
  end

  scenario 'display record creation date' do
    expect(page).to have_content(@record.created_at.strftime('%B %d, %Y at %I:%M %p'))
  end
end

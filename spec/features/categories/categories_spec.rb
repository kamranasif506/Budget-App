require 'rails_helper'

RSpec.feature 'Categories index', type: :feature do
  let(:user) { User.create!(name: 'John', email: 'kamran@gmail.com', password: 'abcdef123234!') }

  before(:each) do
    login_as(user, scope: :user)
    @category1 = Category.create!(name: 'Example Category 1', author: user) do |category|
      category.icon.attach(io: Tempfile.new(['example_image', '.png']), filename: 'example_image.png',
                           content_type: 'image/png')
    end
    @category2 = Category.create!(name: 'Example Category 2', author: user) do |category|
      category.icon.attach(io: Tempfile.new(['example_image', '.png']), filename: 'example_image.png',
                           content_type: 'image/png')
    end
    @record1 = Record.create!(name: 'Example transaction 1', amount: 24, author: user)
    RecordItem.create(record: @record1, category_id: @category1)
    @record2 = Record.create!(name: 'Example transaction 2', amount: 50, author: user)
    RecordItem.create(record: @record2, category_id: @category1)
    @record3 = Record.create!(name: 'Example transaction 3', amount: 30, author: user)
    RecordItem.create(record: @record3, category_id: @category2)
    visit categories_path
  end
  
  scenario 'display category names' do
    expect(page).to have_content('Example Category 1').and have_content('Example Category 2')
  end

  scenario 'display category images and total amount and monthly budget' do
    expect(page).to have_css('img[src*="example_image.png"]', count: 2)
  end

  scenario 'click on category takes to transaction page of that category' do
    click_link(@category1.name)
    expect(page).to have_current_path(category_records_path(@category1))
  end
end
require 'rails_helper'

RSpec.feature 'Splash Screen', type: :feature do
  scenario 'User interacts with the feature' do
    visit root_path

    # Your Capybara test steps here
    expect(page).to have_content('Budget App')
  end
end

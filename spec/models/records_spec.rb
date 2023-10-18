# spec/models/record_spec.rb

require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  after(:each) do
    user.destroy if user.persisted?
  end
  it 'is valid with valid attributes' do
    category = Category.create(name: 'Example Category', author: user)
    record = Record.new(name: 'Example record', amount: 100.00, author: user)

    expect(record).to be_valid
  end

  it 'is not valid without a name' do
    category = Category.create(name: 'Example Category', author: user)
    record = Record.new(amount: 100.00, author: user)
    expect(record).not_to be_valid
    expect(record.errors[:name]).to include("can't be blank")
  end

  it 'is not valid without an amount' do
    category = Category.create(name: 'Example Category', author: user)
    record = Record.new(name: 'Example record', author: user)

    expect(record).not_to be_valid
    expect(record.errors[:amount]).to include("can't be blank")
  end

  it 'is not valid without an author' do
    category = Category.create(name: 'Example Category', author: user)
    record = Record.new(name: 'Example record', amount: 100.00)

    expect(record).not_to be_valid
    expect(record.errors[:author]).to include('must exist')
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = Record.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
    end
  end
end
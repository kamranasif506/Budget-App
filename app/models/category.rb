class Category < ApplicationRecord
  has_many :record_items
  has_many :records, through: :record_items
  belongs_to :author, class_name: 'User'
end

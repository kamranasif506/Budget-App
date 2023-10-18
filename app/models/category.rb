class Category < ApplicationRecord
  has_many :record_items
  has_many :records, through: :record_items
  belongs_to :author, class_name: 'User'

  has_one_attached :icon
  validates :icon, presence: true

  def total_amount
    records.sum(:amount)
  end
end

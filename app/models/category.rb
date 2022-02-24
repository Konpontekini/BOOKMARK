class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, uniqueness: true
  validates :name, inclusion: { in: %w(home fasion) }
  # ['small', 'medium', '...' ]
end

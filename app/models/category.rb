class Category < ApplicationRecord
  has_many :items
  validates :name, uniqueness: true
end

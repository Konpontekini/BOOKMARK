class Category < ApplicationRecord
  belongs_to :user
  has_many :items
  validates :name, uniqueness: true
end

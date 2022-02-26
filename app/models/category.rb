class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, uniqueness: true
  validates :name, inclusion: { in: ["homeware", "beauty", "gifts", "music", "sports", "gardening", "electricals", "clothing", "makeups", "footwear", "fitness", "travel", "accessories", "books", "pets"] }
  # ['small', 'medium', '...' ]
end

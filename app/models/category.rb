class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, uniqueness: true
  validates :name, inclusion: { in: ["accessories", "beauty", "books", "clothing", "electricals", "fitness", "footwear", "gardening", "gifts", "homeware", "makeups", "music", "pets", "sports", "travel"] }
  CATEGORIES = ["accessories", "beauty", "books", "clothing", "electricals", "fitness", "footwear", "gardening", "gifts", "homeware", "makeups", "music", "pets", "sports", "travel"]
  # ['small', 'medium', '...' ]
end

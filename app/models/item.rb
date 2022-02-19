class Item < ApplicationRecord
  belongs_to :user
  validates :category, :item_url, presence: true
  validates :item_url, uniqueness: true
end

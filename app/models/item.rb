class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates  :item_url, presence: true
  validates :item_url, uniqueness: true
end

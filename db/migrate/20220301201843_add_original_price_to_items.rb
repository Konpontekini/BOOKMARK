class AddOriginalPriceToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :original_price, :string
  end
end

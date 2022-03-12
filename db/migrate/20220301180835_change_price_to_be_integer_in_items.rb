class ChangePriceToBeStringInItems < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :price, :string
  end
end

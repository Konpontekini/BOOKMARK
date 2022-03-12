class AddCurrencyToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :currency, :string
  end
end

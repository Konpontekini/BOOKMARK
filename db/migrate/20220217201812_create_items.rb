class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.string :category
      t.text :description
      t.string :item_url
      t.string :image_url
      t.boolean :purchased

      t.timestamps
    end
  end
end

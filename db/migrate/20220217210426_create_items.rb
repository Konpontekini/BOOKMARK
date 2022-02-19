class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.string :category
      t.text :description
      t.text :item_url
      t.text :image_url
      t.boolean :purchased
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

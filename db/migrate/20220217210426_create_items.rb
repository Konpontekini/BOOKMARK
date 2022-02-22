class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.text :description
      t.text :item_url
      t.text :image_url
      t.boolean :purchased


      t.timestamps
    end
  end
end

class ChangeImageUrlToBeArrayInItems < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :image_url, :text, array: true, default: [], using: "(string_to_array(image_url, ','))"
  end
end

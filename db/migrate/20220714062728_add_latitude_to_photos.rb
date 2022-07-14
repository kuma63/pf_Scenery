class AddLatitudeToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :latitude, :float
  end
end

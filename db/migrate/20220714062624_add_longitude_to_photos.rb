class AddLongitudeToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :longitude, :float
  end
end

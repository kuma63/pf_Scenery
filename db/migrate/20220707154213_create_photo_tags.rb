class CreatePhotoTags < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_tags do |t|
      t.integer :tag_id
      t.integer :photo_id

      t.timestamps
    end
  end
end

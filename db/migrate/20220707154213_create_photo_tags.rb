class CreatePhotoTags < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_tags do |t|
      t.integer :tag_id
      t.integer :photo_id

      t.timestamps
    end

    # 同じタグを２回保存する事が出来ないようになる
    add_index :photo_tags, [:photo_id, :tag_id], unique: true
  end
end

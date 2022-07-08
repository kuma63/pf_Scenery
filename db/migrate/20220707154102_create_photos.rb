class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.text :body
      t.string :address
      

      t.timestamps
    end
  end
end

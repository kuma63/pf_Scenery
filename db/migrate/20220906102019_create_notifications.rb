class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.integer :photo_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :is_checked, default: false, null: false

      t.timestamps
    end
  end
end

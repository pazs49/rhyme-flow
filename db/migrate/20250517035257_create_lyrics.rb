class CreateLyrics < ActiveRecord::Migration[8.0]
  def change
    create_table :lyrics do |t|
      t.string :title
      t.string :body
      t.string :genre
      t.string :mood
      t.boolean :public
      t.integer :likes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

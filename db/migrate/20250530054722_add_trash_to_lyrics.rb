class AddTrashToLyrics < ActiveRecord::Migration[8.0]
  def change
    add_column :lyrics, :trashed, :boolean
  end
end

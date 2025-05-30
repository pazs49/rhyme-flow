class UpdateLyricsTable < ActiveRecord::Migration[8.0]
  def change
    change_column :lyrics, :trashed, :boolean, default: false
  end
end

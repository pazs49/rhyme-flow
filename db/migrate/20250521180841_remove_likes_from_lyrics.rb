class RemoveLikesFromLyrics < ActiveRecord::Migration[8.0]
  def change
    remove_column :lyrics, :likes, :integer
  end
end

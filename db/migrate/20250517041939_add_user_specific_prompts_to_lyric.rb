class AddUserSpecificPromptsToLyric < ActiveRecord::Migration[8.0]
  def change
    add_column :lyrics, :user_specific_prompts, :string
  end
end

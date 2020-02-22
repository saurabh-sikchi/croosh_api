class AddKnownForToCelebs < ActiveRecord::Migration[6.0]
  def change
    add_column :celebs, :known_for, :text
  end
end

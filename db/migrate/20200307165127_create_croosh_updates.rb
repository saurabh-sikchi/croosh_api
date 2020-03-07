class CreateCrooshUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :croosh_updates do |t|
      t.references :croosh, null: false, foreign_key: true
      t.text :update_text
    end
  end
end

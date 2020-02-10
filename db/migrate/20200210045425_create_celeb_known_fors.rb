class CreateCelebKnownFors < ActiveRecord::Migration[6.0]
  def change
    create_table :celeb_known_fors do |t|
      t.references :celeb, null: false, foreign_key: true
      t.references :known_for, null: false, foreign_key: true

      t.timestamps
    end
  end
end

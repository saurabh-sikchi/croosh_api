class CreateCelebs < ActiveRecord::Migration[6.0]
  def change
    create_table :celebs do |t|
      t.string :name
      t.string :nick
      t.integer :rate_per_croosh
      t.boolean :ready_to_go_live, default: false, null: false

      t.timestamps
    end
  end
end

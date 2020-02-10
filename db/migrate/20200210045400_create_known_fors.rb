class CreateKnownFors < ActiveRecord::Migration[6.0]
  def change
    create_table :known_fors do |t|
      t.string :name

      t.timestamps
    end
  end
end

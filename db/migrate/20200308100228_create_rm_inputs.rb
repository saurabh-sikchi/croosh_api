class CreateRmInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :rm_inputs do |t|
      t.text :input_text
      t.string :name, default: '', null: false
      t.references :croosh
      t.timestamps
    end
  end
end

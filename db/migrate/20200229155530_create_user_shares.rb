class CreateUserShares < ActiveRecord::Migration[6.0]
  def change
    create_table :user_shares do |t|
      t.references :user, null: false, foreign_key: true
      t.references :croosh, null: false, foreign_key: true

      t.integer :num, null: false, default: 0

      t.timestamps
    end
  end
end

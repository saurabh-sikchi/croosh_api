class CreateCrooshes < ActiveRecord::Migration[6.0]
  def change
    create_table :crooshes do |t|
      t.references :celeb, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :user_likes_count, null: false, default: 0
      t.integer :celeb_likes_count, null: false, default: 0

      t.timestamps
    end
  end
end

class CreateCelebLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :celeb_likes do |t|
      t.references :celeb, null: false, foreign_key: true
      t.references :croosh, null: false, foreign_key: true

      t.timestamps
    end
  end
end

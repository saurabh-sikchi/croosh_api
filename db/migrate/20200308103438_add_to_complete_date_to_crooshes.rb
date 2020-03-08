class AddToCompleteDateToCrooshes < ActiveRecord::Migration[6.0]
  def change
    add_column :crooshes, :to_complete_date, :date
  end
end

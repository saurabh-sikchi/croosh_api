class AddUserSharesCountToCrooshes < ActiveRecord::Migration[6.0]
  def change
    add_column :crooshes, :user_shares_count, :integer, null: false, default: 0
  end
end

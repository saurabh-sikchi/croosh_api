class AddIsRequestToCrooshes < ActiveRecord::Migration[6.0]
  def change
    add_column :crooshes, :is_request, :boolean, default: false, null: false
  end
end

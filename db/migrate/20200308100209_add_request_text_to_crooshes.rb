class AddRequestTextToCrooshes < ActiveRecord::Migration[6.0]
  def change
    add_column :crooshes, :request_text, :text
  end
end

class AddColumnsToCelebs < ActiveRecord::Migration[6.0]
  def change
    add_column :celebs, :email, :string
    add_column :celebs, :phone_number, :string
    add_column :celebs, :address, :text
    add_column :celebs, :password_plaintext, :string
  end
end

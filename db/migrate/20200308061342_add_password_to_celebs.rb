class AddPasswordToCelebs < ActiveRecord::Migration[6.0]
  def change
    add_column :celebs, :password_digest, :string
  end
end

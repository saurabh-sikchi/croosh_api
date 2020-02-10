class AddColumnsToOtpAuthentication < ActiveRecord::Migration[6.0]
  def change
    add_column :otp_authentications, :succeeded, :boolean, default: false, null: false
    add_column :otp_authentications, :user_id, :integer, index: true
  end
end

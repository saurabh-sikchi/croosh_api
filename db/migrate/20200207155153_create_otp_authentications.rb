class CreateOtpAuthentications < ActiveRecord::Migration[6.0]
  def change
    create_table :otp_authentications do |t|
      t.string :phone_number, null: false
      t.string :otp, null: false

      t.timestamps
    end
  end
end

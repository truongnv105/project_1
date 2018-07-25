class AddPhoneNumberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone_number, :string
    add_index :users, [:email, :phone_number], unique: true
  end
end

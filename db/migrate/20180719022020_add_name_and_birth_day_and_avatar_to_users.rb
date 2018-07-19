class AddNameAndBirthDayAndAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :birth_day, :datetime
    add_column :users, :avatar, :string
  end
end

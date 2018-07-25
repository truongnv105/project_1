class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :providers do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :email
      t.string :uid
      t.string :token

      t.timestamps
    end
    add_index :providers, [:provider, :uid], unique: true
  end
end

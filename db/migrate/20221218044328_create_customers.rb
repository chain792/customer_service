class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.string :gender
      t.date :birthday

      ## Database authenticatable
      t.string :email,              null: false
      t.string :crypted_password
      t.string :salt

      t.timestamps null: false
    end

    add_index :customers, "LOWER(email)",                unique: true
    add_index :customers, [:family_name_kana, :given_name_kana]
  end
end

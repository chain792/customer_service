# frozen_string_literal: true

class CreateStaffMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :staff_members do |t|
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :suspended, null: false, default: false

      ## Database authenticatable
      t.string :email,              null: false
      t.string :crypted_password
      t.string :salt

      t.timestamps null: false
    end

    add_index :staff_members, "LOWER(email)",                unique: true
    add_index :staff_members, [:family_name_kana, :given_name_kana]
  end
end

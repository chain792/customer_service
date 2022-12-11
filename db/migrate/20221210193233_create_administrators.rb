# frozen_string_literal: true

class CreateAdministrators < ActiveRecord::Migration[7.0]
  def change
    create_table :administrators do |t|
      t.boolean :suspended, null: false, default: false

      ## Database authenticatable
      t.string :email,              null: false
      t.string :crypted_password
      t.string :salt

      t.timestamps null: false
    end

    add_index :administrators, "LOWER(email)",                unique: true
  end
end

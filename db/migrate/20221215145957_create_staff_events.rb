class CreateStaffEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :staff_events do |t|
      t.references :staff_member, null: false, foreign_key: true, index: false
      t.string :type, null: false

      t.timestamps
    end

    add_index :staff_events, :created_at
    add_index :staff_events, [:staff_member_id, :created_at]
  end
end

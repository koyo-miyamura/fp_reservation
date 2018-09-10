class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer  :fp_id, null: false
      t.integer  :user_id, null: false
      t.datetime :reserved_on, null: false

      t.timestamps
      t.index :fp_id
      t.index :user_id
      t.index [:fp_id,   :reserved_on]
      t.index [:user_id, :reserved_on]
    end
  end
end

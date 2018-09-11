class CreateFpReservableTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :fp_reservable_times do |t|
      t.integer :fp_id, null: false
      t.datetime :reservable_on, null: false

      t.timestamps
      t.index :fp_id
      t.index [:fp_id, :reservable_on]
    end
  end
end

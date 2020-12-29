class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :event
      t.references :user
      t.integer    :inviter
      t.integer    :status
      t.timestamps
    end
    add_index :bookings, [:event_id, :user_id], unique: true
  end
end

class AddIndexToEvents < ActiveRecord::Migration[6.0]
  def change
    add_index :events, :start_time
    add_index :events, :end_time
  end
end

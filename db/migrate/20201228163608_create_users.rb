class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string    :username, unique: true
      t.string    :email
      t.string    :phone
      t.boolean   :archived, default: false
      t.timestamps
    end
  end
end

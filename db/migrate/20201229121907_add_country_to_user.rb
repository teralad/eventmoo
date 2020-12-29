class AddCountryToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :country_iso, :string, default: 'US'
  end
end

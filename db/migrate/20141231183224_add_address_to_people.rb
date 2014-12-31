class AddAddressToPeople < ActiveRecord::Migration
  def change
    add_column :people, :address_1, :string
    add_column :people, :address_2, :string
    add_column :people, :address_city, :string
    add_column :people, :address_state, :string
    add_column :people, :address_zip, :string
    add_column :people, :address_country, :string
  end
end

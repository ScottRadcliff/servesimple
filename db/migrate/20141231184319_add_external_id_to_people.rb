class AddExternalIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :external_id, :string
    add_index :people, :external_id
  end
end

class AddAccountRefToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :account, index: true
    add_foreign_key :people, :accounts
  end
end

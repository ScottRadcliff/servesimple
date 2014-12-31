class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :account, index: true
      t.string :name
      t.boolean :login
      t.string :color

      t.timestamps null: false
    end
    add_foreign_key :roles, :accounts
  end
end

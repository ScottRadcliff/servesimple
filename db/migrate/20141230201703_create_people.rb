class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :gender, limit: 1
      t.string :phone
      t.string :email
      t.date :date_of_birth

      t.timestamps null: false
    end
    add_index :people, :name
  end
end

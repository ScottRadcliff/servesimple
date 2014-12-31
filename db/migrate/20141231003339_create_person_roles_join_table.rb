class CreatePersonRolesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :people, :roles do |t|
      t.index [:person_id, :role_id], unique: true
    end
  end
end

class AddIndexToPeopleMail < ActiveRecord::Migration[5.0]
  def change
    add_index :people, :mail, unique: true
  end
end

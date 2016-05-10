class RemovePasswordFromPeople < ActiveRecord::Migration[5.0]
  def change
    remove_column :people, :password, :string
  end
end

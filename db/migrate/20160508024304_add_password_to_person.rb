class AddPasswordToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :password, :string
  end
end

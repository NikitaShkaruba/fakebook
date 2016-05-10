class AddStatusToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :status, :string
  end
end

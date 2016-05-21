class AddPictureToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :picture, :string
  end
end

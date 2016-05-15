class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.date :date_of_birth
      t.string :city
      t.string :mail
      t.string :phone_number
      t.string :gender
      t.string :relationship
      t.string :profession

      t.timestamps
    end
  end
end

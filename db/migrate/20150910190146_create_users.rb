class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :post
      t.string :password
      t.string :password_confirmation
      t.string :fname
      t.string :birthday
      t.string :gender
      t.string :city

      t.timestamps null: false
    end
  end
end

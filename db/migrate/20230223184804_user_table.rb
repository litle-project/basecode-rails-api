class UserTable < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      create_table :users do |t|
        t.string :name
        t.string :email
        t.string :password
        t.string :phone_number

        t.timestamps
      end
    end
  end
end

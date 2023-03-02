class UserTable < ActiveRecord::Migration[7.0]
  def up
    create_table :users, id: :primary_key do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :phone_number
      t.timestamps
      t.timestamp :deleted_at
    end
  end

  def down
    drop_table :users
  end
end

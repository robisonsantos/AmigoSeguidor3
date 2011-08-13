class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.boolean :group_admin

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

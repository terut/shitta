class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name
      t.text :bio

      t.timestamps

    end

    change_table :users do |t|
      t.index :username
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.text :bio

      t.timestamps
    end

    change_table :users do |t|
      t.index :username, unique: true
      t.index :email, unique: true
    end
  end
end

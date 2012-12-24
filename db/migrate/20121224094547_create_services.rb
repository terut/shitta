class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :user, null:false
      t.string :username, null: false
      t.string :token, null: false

      t.timestamps
    end
    add_index :services, :user_id
  end
end

class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :username
      t.string :token
      t.string :provider

      t.timestamps
    end
  end
end

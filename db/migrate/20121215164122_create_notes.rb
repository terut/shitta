class CreateNotes < ActiveRecord::Migration
  # TODO review e.g. db length
  def change
    create_table :notes do |t|
      t.references :user, null:false
      t.string :title, null: false
      t.string :raw_body, null: false

      t.timestamps
    end
    add_index :notes, :user_id
  end
end

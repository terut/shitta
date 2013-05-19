class CreateComments < ActiveRecord::Migration
  # TODO review e.g. db length
  def change
    create_table :comments do |t|
      t.references :note, null: false
      t.references :user, null: false
      t.text :raw_body, null: false

      t.timestamps
    end
    add_index :comments, :note_id
    add_index :comments, :user_id
  end
end

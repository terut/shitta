class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.references :note, null: false
      t.references :user, null: false
      t.text :raw_body, null: false

      t.timestamps
    end

    change_table :comments do |t|
      t.index :note_id
      t.index :user_id
    end
  end
end

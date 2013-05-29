class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.references :user, null:false
      t.string :title, null: false
      t.string :raw_body, null: false
      t.string :uuid

      t.timestamps
    end

    change_table :notes do |t|
      t.index :user_id
      t.index :uuid, unique: true
    end
  end
end

class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.references :user, null: false
      t.references :note, index: true, null: false
      t.integer :point, default: 1, null: false

      t.timestamps
    end
    change_table :favorites do |t|
      t.index [:user_id, :note_id], unique: true
    end
  end
end

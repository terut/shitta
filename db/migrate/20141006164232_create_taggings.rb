class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :tags, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :name, null: false
      t.integer :taggings_count, default: 0, null: false
      t.timestamps
    end

    create_table :taggings, options: 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.references :note, null: false
      t.references :tag, null: false
      t.timestamps
    end

    change_table :tags do |t|
      t.index :name, unique: true
    end

    change_table :taggings do |t|
      t.index [:tag_id, :note_id], unique: true
      t.index :note_id
    end
  end
end

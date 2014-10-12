class AddCommentsCountToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :comments_count, :integer, default: 0, null: false
  end
end

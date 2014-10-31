class AddDeletedAtToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :deleted_at, :datetime
  end
end

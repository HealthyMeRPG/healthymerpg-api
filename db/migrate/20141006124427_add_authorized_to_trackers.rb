class AddAuthorizedToTrackers < ActiveRecord::Migration
  def change
    add_column :trackers, :authorized, :boolean
    add_index :trackers, :authorized
  end
end

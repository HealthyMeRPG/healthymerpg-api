class CreateTrackers < ActiveRecord::Migration
  def change
    create_table :trackers do |t|
      t.integer :tracker
      t.string :uuid
      t.string :omh_shim_id
      t.references :user, index: true
      t.boolean :active

      t.timestamps
    end

    add_index :trackers, :tracker
    add_index :trackers, :uuid, unique: true
    add_index :trackers, :omh_shim_id, unique: true
    add_index :trackers, :active
  end
end

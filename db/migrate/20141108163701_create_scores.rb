class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :stamina
      t.integer :strength
      t.integer :mind
      t.integer :vitality
      t.integer :agility
      t.references :user, index: true

      t.timestamps
    end
  end
end

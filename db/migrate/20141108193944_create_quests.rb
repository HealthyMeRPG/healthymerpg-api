class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :title
      t.integer :stamina_reward
      t.integer :strength_reward
      t.integer :mind_reward
      t.integer :vitality_reward
      t.integer :agility_reward
      t.integer :activity
      t.integer :activity_amount

      t.timestamps
    end
  end
end

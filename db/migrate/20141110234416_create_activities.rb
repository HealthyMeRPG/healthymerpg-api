class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true
      t.date :activity_date
      t.integer :steps
      t.integer :calories_burned
      t.integer :floors_climbed
      t.integer :very_active_minutes
      t.boolean :finalized, index: true, default: false

      t.timestamps
    end
  end
end

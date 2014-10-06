class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.references :user, index: true
      t.string :key
      t.string :ip
      t.string :user_agent
      t.datetime :accessed_at
      t.datetime :revoked_at
    end

    add_index :user_sessions, :key, unique: true
    add_index :user_sessions, :accessed_at
    add_index :user_sessions, :revoked_at
    add_index :user_sessions, [:accessed_at, :revoked_at]
  end
end

class EventsUsersRelationships < ActiveRecord::Migration
  def self.up
    create_table :events_users, :id => false do |t|
      t.column :event_id,  :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
    User.all.each do |u|
      execute "INSERT INTO events_users (event_id, user_id) VALUES (1, #{u.id})"
    end
    remove_column :users, :event_id
  end

  def self.down
    create_column :users, :event_id
    drop_table :events_users
  end
end

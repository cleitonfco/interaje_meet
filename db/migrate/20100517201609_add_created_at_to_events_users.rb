class AddCreatedAtToEventsUsers < ActiveRecord::Migration
  def self.up
    rename_table :events_users, :subscriptions
    add_column :subscriptions, :created_at, :datetime
  end

  def self.down
    remove_column :subscriptions, :created_at
    rename_table :subscriptions, :events_users
  end
end

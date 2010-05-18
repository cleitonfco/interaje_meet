class RemoveSubscriptionAtFromSubscriptions < ActiveRecord::Migration
  def self.up
    remove_column :subscriptions, :subscription_at
  end

  def self.down
    add_column :subscriptions, :subscription_at, :datetime
  end
end

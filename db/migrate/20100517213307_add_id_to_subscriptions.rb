class AddIdToSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :id, :integer, :primary => true
  end

  def self.down
    remove_column :subscriptions, :id
  end
end

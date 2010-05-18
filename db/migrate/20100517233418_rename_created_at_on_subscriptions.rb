class RenameCreatedAtOnSubscriptions < ActiveRecord::Migration
  def self.up
    rename_column :subscriptions, :created_at, :subscription_at
  end

  def self.down
    rename_column :subscriptions, :subscription_at, :created_at
  end
end

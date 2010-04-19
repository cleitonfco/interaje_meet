class ReplaceSegmentAtUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :segment
    add_column :users, :activity, :string
  end

  def self.down
    remove_column :users, :activity
    add_column :users, :segment, :string
  end
end

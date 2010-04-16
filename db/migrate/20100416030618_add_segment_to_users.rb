class AddSegmentToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :segment, :integer
  end

  def self.down
    remove_column :users, :segment
  end
end

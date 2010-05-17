class RenameCodeToTokienOnUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :code, :tokien
  end

  def self.down
    rename_column :users, :tokien, :code
  end
end

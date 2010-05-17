class RenameTokienToTokenOnUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :tokien, :token
  end

  def self.down
    rename_column :users, :token, :tokien
  end
end
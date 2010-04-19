class AddTwitterDataToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_profile, :string
    add_column :users, :twitter_name, :string
    add_column :users, :twitter_image, :string
    add_column :users, :twitter_url, :string
    add_column :users, :twitter_description, :string
    add_column :users, :twitter_location, :string
    add_column :users, :twitter_friends, :integer
    add_column :users, :twitter_followers, :integer
    add_column :users, :twitter_statuses_count, :integer
    add_column :users, :twitter_since, :datetime
  end

  def self.down
    remove_column :users, :twitter_since
    remove_column :users, :twitter_statuses_count
    remove_column :users, :twitter_followers
    remove_column :users, :twitter_friends
    remove_column :users, :twitter_location
    remove_column :users, :twitter_description
    remove_column :users, :twitter_url
    remove_column :users, :twitter_image
    remove_column :users, :twitter_name
    remove_column :users, :twitter_profile
  end
end

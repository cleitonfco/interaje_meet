class PopulateSubscriptions < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      Subscription.create(:event_id => 1, :user_id => u.id)
    end
  end

  def self.down
  end
end

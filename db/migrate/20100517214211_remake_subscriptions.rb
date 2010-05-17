class RemakeSubscriptions < ActiveRecord::Migration
  def self.up
    drop_table :subscriptions
    create_table :subscriptions do |t|
      t.integer :event_id,   :null => false
      t.integer :user_id,    :null => false
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :subscriptions
    create_table :subscriptions, :id => false, :force => true do |t|
      t.integer  :event_id,   :null => false
      t.integer  :user_id,    :null => false
      t.datetime :created_at
      t.integer  :id
    end
  end
end

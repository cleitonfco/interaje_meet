class User < ActiveRecord::Base
  belongs_to :event
  named_scope :twitters, lambda { |event| 
    { :conditions => ["(twitter is not NULL AND twitter <> '') and event_id = ?", event.id], :order => 'created_at DESC' }
  }
end

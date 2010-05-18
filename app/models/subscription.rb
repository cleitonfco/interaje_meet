class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  named_scope :by_event, lambda { |event| {
    :order => "subscriptions.id DESC", :conditions => ["event_id = ?", event]
  } }

end

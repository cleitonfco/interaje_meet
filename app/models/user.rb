class User < ActiveRecord::Base
  belongs_to :event
  named_scope :twitters, lambda { |event| 
    { :conditions => ["(twitter is not NULL AND twitter <> '') and event_id = ?", event.id], :order => 'created_at DESC' }
  }
  
  validates_presence_of :name, :email
  
  def humanize_site
    "http://#{site.downcase.gsub("http://", "")}"
  end
end

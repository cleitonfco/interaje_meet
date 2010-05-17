class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :events, :through => :subscriptions
  default_scope :joins => :subscriptions, :order => "subscriptions.created_at desc"
  named_scope :twitters, lambda { |event| 
    { :conditions => ["(twitter is not NULL AND twitter <> '') and subscriptions.event_id = ?", event] }
  }
  named_scope :recents, lambda { |last, event| 
    { :conditions => ["subscriptions.event_id = ? and subscriptions.created_at > ?", event, last] }
  }

  validates_presence_of :name, :email

  before_create :generate_token

  def humanize_site
    "http://#{site.downcase.gsub("http://", "")}"
  end

  protected
    def generate_token
      token = UUID.generate.split('-')
      self.token = "#{token[0]}#{token[1]}"
    end
end

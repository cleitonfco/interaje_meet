class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :events, :through => :subscriptions

  named_scope :twitters, :conditions => "twitter is not NULL AND twitter <> ''", :order => "subscriptions.id DESC"
  named_scope :by_token, lambda { |id, token| { :conditions => ["id = ? and token = ?", id, token], :limit => 1 } }
  named_scope :recents, lambda { |event, last| {
    :select => "users.*, subscriptions.id AS subscription_id", :joins => :subscriptions, :order => "subscriptions.id DESC", 
    :conditions => ["subscriptions.id > ? and subscriptions.event_id = ?", last, event]
  } }


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

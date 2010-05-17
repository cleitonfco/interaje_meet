class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :events, :through => :subscriptions
  named_scope :twitters, lambda { |event| 
    { :conditions => ["(twitter is not NULL AND twitter <> '') and event_id = ?", event.id], :order => 'created_at DESC' }
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

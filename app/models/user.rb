class User < ActiveRecord::Base
  belongs_to :event
  named_scope :twitters, lambda { |event| 
    { :conditions => ["(twitter is not NULL AND twitter <> '') and event_id = ?", event.id], :order => 'created_at DESC' }
  }

  validates_presence_of :name, :email

  before_save :generate_code

  def humanize_site
    "http://#{site.downcase.gsub("http://", "")}"
  end

  protected
    def generate_code
      code = UUID.generate.split('-')
      self.code = "#{code[0]}#{code[1]}"
    end
end

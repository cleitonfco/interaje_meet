class Event < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, :through => :subscriptions

  before_create :generate_slug

  private
    def generate_slug
      self.slug = self.name.parameterize.to_s
    end
end

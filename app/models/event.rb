class Event < ActiveRecord::Base
  has_many :users
  before_create :generate_slug

  private
    def generate_slug
      self.slug = self.name.parameterize.to_s
    end
end

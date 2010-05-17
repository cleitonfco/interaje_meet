class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  before_create :generate_slug

  private
    def generate_slug
      self.slug = self.name.parameterize.to_s
    end
end

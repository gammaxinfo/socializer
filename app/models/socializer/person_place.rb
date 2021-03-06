module Socializer
  class PersonPlace < ActiveRecord::Base
    attr_accessible :city_name, :current

    # Relationships
    belongs_to :person

    # Validations
    validates :city_name, presence: true
  end
end

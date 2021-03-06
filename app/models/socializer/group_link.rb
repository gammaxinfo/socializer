module Socializer
  class GroupLink < ActiveRecord::Base
    attr_accessible :label, :url

    # Relationships
    belongs_to :group

    # Validations
    validates :label, presence: true
    validates :url, presence: true
  end
end

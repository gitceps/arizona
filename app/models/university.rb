class University < ActiveRecord::Base
    has_many :distribution_major
    has_many :distribution_minor
        def self.search(search)
          University.where("name LIKE ?", "%#{:search}%") 
        end
end

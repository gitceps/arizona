class University < ActiveRecord::Base
    has_many :distribution_major
    has_many :distribution_minor
    has_many :department
        def self.search(search)
          University.where("name LIKE ?", "%#{:search}%") 
<<<<<<< HEAD
        end        
    
=======
        end
>>>>>>> 8e1ef39a693b59fed5005c7412bc6ab8688fab3a
end


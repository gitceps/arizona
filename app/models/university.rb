class University < ActiveRecord::Base
 
        def self.search(search)
          University.where("name LIKE ?", "%#{:search}%") 
        end        
    
end


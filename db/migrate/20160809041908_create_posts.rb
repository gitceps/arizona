class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.float :point
        
      t.timestamps null: false
    end
    
  end
end

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

    t.string "point"    
        
      t.timestamps null: false
    end
  end
end

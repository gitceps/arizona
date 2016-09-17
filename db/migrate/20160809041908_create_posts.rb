class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :title
      t.string :author
      t.integer :view
      t.integer :like
      t.integer :dislike
    
      t.text :content
      
        
      t.timestamps null: false
    end
    
  end
end

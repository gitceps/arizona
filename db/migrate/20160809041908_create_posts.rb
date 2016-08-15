class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.float :point
      t.string :name
      t.string :dept
      t.timestamps null: false
    end
    
  end
end

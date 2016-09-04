class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :university_id
      t.integer :department_id
      t.float :point
        
      #facebook login information
      t.string :uid
      t.string :name
      t.string :provider
        
      t.timestamps null: false
    end
  end
end

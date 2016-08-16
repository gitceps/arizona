class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|      
        t.string :name, null: false
        t.string  :location
        t.string  :is_4_5
        t.string  :is_public
      t.timestamps null: false
    end
  end
end

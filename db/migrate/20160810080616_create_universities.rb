class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
        t.string :year
        t.string :total_students
        t.string :name, null: false
        t.string  :location
        t.string  :is_4_5
        t.string  :is_public
        t.integer :aplus_number
        t.integer :azero_number
        t.integer :aminus_number
        t.integer :view
      t.timestamps null: false
    end
  end
end

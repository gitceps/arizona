class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :university_id
        
      t.string :department_name
      t.string :college
      t.string :department_code
      t.string :isdaytime
      t.string :department_property
      t.string :department_status
      t.string :department_big_affiliation
      t.string :department_medium_affiliation
      t.string :department_small_affiliation
      t.string :course_term
      t.string :degree
      
      t.timestamps null: false
    end
  end
end

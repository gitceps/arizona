class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      
      t.float :point
      t.string :name
      t.string :dept

      t.timestamps null: false
    end
  end
end

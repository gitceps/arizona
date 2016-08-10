class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :point
        
      t.timestamps null: false
    end
    create_table :universitys do |t|
      
    t.string :name
    t.string   :location
    t.boolean  :is_4_5
    t.boolean  :is_public
    #semester 1
    t.integer   :aplus_students_1
    t.float     :aplus_ratio_1
    t.integer   :azero_students_1
    t.float   :azero_ratio_1
    t.integer   :aminus_students_1
    t.float   :aminus_ratio_1
    t.integer   :bplus_students_1
    t.float     :bplus_ratio_1
    t.integer   :bzero_students_1
    t.float   :bzero_ratio_1
    t.integer   :bminus_students_1
    t.float   :bminus_ratio_1
    t.integer   :cplus_students_1
    t.float     :cplus_ratio_1
    t.integer   :czero_students_1
    t.float   :czero_ratio_1
    t.integer   :cminus_students_1
    t.float   :cminus_ratio_1
    t.integer   :dplus_students_1
    t.float     :dplus_ratio_1
    t.integer   :dzero_students_1
    t.float   :dzero_ratio_1
    t.integer   :dminus_students_1
    t.float   :dminus_ratio_1
    t.integer   :f_students_1
    t.float     :f_ratio_1
    #semester 2
    t.integer   :aplus_students_2
    t.float     :aplus_ratio_2
    t.integer   :azero_students_2
    t.float   :azero_ratio_2
    t.integer   :aminus_students_2
    t.float   :aminus_ratio_2
    t.integer   :bplus_students_2
    t.float     :bplus_ratio_2
    t.integer   :bzero_students_2
    t.float   :bzero_ratio_2
    t.integer   :bminus_students_2
    t.float   :bminus_ratio_2
    t.integer   :cplus_students_2
    t.float     :cplus_ratio_2
    t.integer   :czero_students_2
    t.float   :czero_ratio_2
    t.integer   :cminus_students_2
    t.float   :cminus_ratio_2
    t.integer   :dplus_students_2
    t.float     :dplus_ratio_2
    t.integer   :dzero_students_2
    t.float   :dzero_ratio_2
    t.integer   :dminus_students_2
    t.float   :dminus_ratio_2
    t.integer   :f_students_2
    t.float     :f_ratio_2
    t.timestamps null: false
    end
  end
end

class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|

      t.text :content
      t.string :author
      t.integer :like
      t.integer :dislike
      t.integer :post_id
      #외래키가 참조하는 필드 이름은 반드시 참조하는 테이블명_id 형태가 되어야 한다.
      t.timestamps null: false
    end
  end
end

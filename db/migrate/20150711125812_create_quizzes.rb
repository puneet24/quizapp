class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|

    	t.string :quiz_name
    	t.string :quiz_type
    	t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :quizzes, :users
  end
end

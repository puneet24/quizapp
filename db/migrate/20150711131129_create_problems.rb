class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
    	t.text :prob_stat
    	t.string :option1
    	t.string :option2
    	t.string :option3
    	t.string :option4
    	t.string :prob_ans
    	t.references :quiz, index: true
      t.timestamps null: false
    end
    add_foreign_key :problems, :quizzes
  end
end

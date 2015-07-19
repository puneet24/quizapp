class CreateQuizAttendeds < ActiveRecord::Migration
  def change
    create_table :quiz_attendeds do |t|
    	t.integer :score
    	t.references :user, index: true
    	t.references :quiz, index: true

      t.timestamps null: false
    end
    add_foreign_key :quiz_attendeds, :users
    add_foreign_key :quiz_attendeds, :quizzes

  end
end

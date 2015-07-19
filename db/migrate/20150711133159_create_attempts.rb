class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
    		t.string :option
    		t.references :user, index: true
    		t.references :quiz, index: true
    		t.references :problem, index: true
      t.timestamps null: false
    end
    add_foreign_key :attempts, :users
    add_foreign_key :attempts, :quizzes
    add_foreign_key :attempts, :problems
  end
end

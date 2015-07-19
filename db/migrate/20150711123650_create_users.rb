class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	 t.string :firstname
    	  t.string :lastname
    	  t.string :username
    	  t.date :date_ob
    	  t.string :password
    	  t.string :country
    	  t.string :email
    	  t.integer :quiz_attempted
    	  t.integer :quiz_organised
    	  t.integer :quiz_won
      t.timestamps null: false
    end
  end
end

class QuizController < ApplicationController
	def create_quiz
	end	
	def create
		create_obj= Quizzes.find_by_sql(["select * from Quizzes where quiz_name = ?  ",params[:quiz_name])


  	if create_obj.empty?
  		new_obj = Quizzes.new
  		new_obj.quiz_name = params[:quiz_name]
  		new_obj.quiz_type = params[:quiz_type]
  		redirect_to action: 'login'
  	else
  		redirect_to action: 'signup'
  	end
  
  		
  end
	end

end

class DashboardController < ApplicationController
  def index
  	if params[:type].nil?
  		params[:type] = "all"
  	end
  	@selected = params[:type]
  	if params[:type].to_s == "all"
  		@all_quiz = Quiz.find_by_sql(["select * from quizzes where user_id != ? ", session[:user_id]])
  	else	  	
		@all_quiz = Quiz.find_by_sql(["select * from quizzes where user_id != ? and quiz_type = ? ", session[:user_id], params[:type]])  
	end		
  end
end


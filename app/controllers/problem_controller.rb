class ProblemController < ApplicationController
	def add_problem
	end
	def add_prob
		prob_obj = Problem.new
		prob_obj.prob_stat = params[:problem]
		prob_obj.option1 = params[:option1]
		prob_obj.option2 = params[:option2]
		prob_obj.option3 = params[:option3]
		prob_obj.option4 = params[:option4]
		prob_obj.prob_ans = params[:answer]
		prob_obj.quiz_id = session[:quiz_id]
		prob_obj.save!
		if params[:decider].to_i == 0
			redirect_to :action => 'add_problem'
		else
			redirect_to :controller => 'dashboard',:action => 'index'
		end
	end
end

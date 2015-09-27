class QuizController < ApplicationController
def create_quiz
end 
def create
puts "&"*50
puts params[:quiz_name]
puts "&"*50
create_obj= Quiz.find_by_sql(["select * from quizzes where quiz_name = ? ",params[:quiz_name]])
if create_obj.empty?
new_obj = Quiz.new
new_obj.quiz_name = params[:quiz_name]
new_obj.quiz_type = params[:quiz_type]
new_obj.user_id = session[:user_id].to_i
new_obj.save!
session[:quiz_id] = new_obj.id
user_obj=User.find(session[:user_id].to_i)
if user_obj.quiz_organised.nil?
user_obj.update_attributes(:quiz_organised => 1)
else
user_obj.update_attributes(:quiz_organised => user_obj.quiz_organised+1)
end
redirect_to :controller=>'problem', :action => 'add_problem'
else
redirect_to action: 'create_quiz'
end
end
def my_quiz
@my_quiz=Quiz.find_by_sql(["select * from quizzes where user_id = ? ",session[:user_id]])
end
def init_quiz
total_count = Problem.find_by_sql(["select * from problems where quiz_id = ? ",params[:quiz_id]]).count
if total_count <= params[:problem_id].to_i
redirect_to action: 'score'
end
@problem=Problem.find_by_sql(["select * from problems where quiz_id = ? ",params[:quiz_id]])[params[:problem_id].to_i]
@quiz_id=params[:quiz_id]
@prob_count=params[:problem_id].to_i+1
if params[:problem_id] != 0
if !params[:option].nil?
prob_info = Attempt.new
temp = Problem.find_by_sql(["select * from problems where quiz_id = ?",params[:quiz_id]])[params[:problem_id].to_i - 1]
prob_info.problem_id = temp.id
prob_info.user_id = session[:user_id]
prob_info.quiz_id = params[:quiz_id]
prob_info.option = params[:option]
prob_info.save!
quiz_info = QuizAttended.find_by_sql(["select *from quiz_attendeds where user_id = ? and quiz_id = ?",session[:user_id],params[:quiz_id]])[0]
#to check answer is correct or not.
prev_correct = Problem.find_by_sql(["select * from problems where quiz_id = ?",params[:quiz_id]])[params[:problem_id].to_i-1]
prev_correct_ans = prev_correct.prob_ans.to_i
score = 0
if prev_correct_ans == params[:option].to_i
score = 1
end
if quiz_info.nil?
# to create entry
quiz_attend_obj = QuizAttended.new
quiz_attend_obj.user_id = session[:user_id]
quiz_attend_obj.score = score
puts "*"*50
puts score
puts "*"*50
quiz_attend_obj.quiz_id = params[:quiz_id]
quiz_attend_obj.save!
else
#update entry
quiz_obj = Quiz.find_by_sql(["select *from quiz_attendeds where quiz_id = ? and user_id = ?",params[:quiz_id],session[:user_id]])[0]
quiz_obj.update_attributes(:score => quiz_obj.score.to_i + score)
end
end
end
end
def score
@quiz_score = QuizAttended.find_by_sql(["select score from quiz_attendeds where quiz_id = ? and user_id = ?",params[:quiz_id], session[:user_id]])[0]
puts "%"*50
puts @quiz_score
puts "%"*50
end

def upload
  uploaded_file = params[:file]
  file_content = uploaded_file.read
  file_content = file_content.to_s.split("\n")
  create_obj= Quiz.find_by_sql(["select * from quizzes where quiz_name = ? ",file_content[0].to_s])
  if create_obj.empty?
    new_obj = Quiz.new
    new_obj.quiz_name = file_content[0].to_s #quiz name
    new_obj.quiz_type = file_content[1].to_s #quiz_type
    new_obj.user_id = session[:user_id].to_i
    new_obj.save!
    session[:quiz_id] = new_obj.id
    user_obj=User.find(session[:user_id].to_i)
    if user_obj.quiz_organised.nil?
      user_obj.update_attributes(:quiz_organised => 1)
    else
      user_obj.update_attributes(:quiz_organised => user_obj.quiz_organised+1)
    end
    no_of_questions = file_content[2].to_i
    i = 0
    while i < no_of_questions
      prob_obj = Problem.new
      prob_obj.prob_stat = file_content[3+i*6+0]
      prob_obj.option1 = file_content[3+i*6+1]
      prob_obj.option2 = file_content[3+i*6+2]
      prob_obj.option3 = file_content[3+i*6+3]
      prob_obj.option4 = file_content[3+i*6+4]
      prob_obj.prob_ans = file_content[3+i*6+5]
      prob_obj.quiz_id = session[:quiz_id]
      prob_obj.save!
      i = i+1
    end
  else
    redirect_to action: 'create_quiz'
  end
  redirect_to :controller=>'dashboard', :action => 'index'
end

end
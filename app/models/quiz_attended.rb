class QuizAttended < ActiveRecord::Base
	belongs to :user
	belongs to :quiz
end

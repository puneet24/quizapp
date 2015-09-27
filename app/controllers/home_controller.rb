class HomeController < ApplicationController
  def index
  end
  def login

  end
  def signup
  	
  end
  def signupsubmit
  	user_obj = User.find_by_sql(["select * from users where username = ? or email = ? ",params[:username],params[:email]])
  	puts "&"*50
  	puts user_obj.inspect
  	puts "&"*50
  	if user_obj.empty?
  		new_obj = User.new
  		new_obj.firstname = params[:firstname]
  		new_obj.lastname = params[:lastname]
  		new_obj.username = params[:username]
  		new_obj.email = params[:email]
  		new_obj.date_ob = params[:date_ob]
  		new_obj.password = params[:password]
  		new_obj.save
  		redirect_to action: 'login'
  	else
  		redirect_to action: 'signup'
  	end
  
  		
  end
  def loginsubmit
    user_obj= User.find_by_sql(["select * from users where username = ? and password = ? ",params[:username],params[:password]])[0]
    puts user_obj.inspect
    if user_obj.nil? 
      redirect_to action: 'login'
    else
      puts user_obj.inspect
      session[:email] = user_obj.email
      session[:user_id] = user_obj.id
      redirect_to :controller=>'dashboard', :action => 'index'
 
    end
  end

  def logout
    session[:email] = nil
    session[:user_id] = nil
    redirect_to action: 'index'
  end

end

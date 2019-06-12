class UsersController < ApplicationController

  # get '/signup' do
  #   if !logged_in?
  #     erb :'users/create_users'
  #   else
  #     redirect '/lists'
  #   end
  # end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:pass_confirm] == ""
      flash[:notice] = "Please enter username and password."
      redirect '/signup'
    elsif params[:password] != params[:pass_confirm]
      flash[:notice] = "Password confirmation does not match password."
      redirect '/'
    else
      @user = User.create(:username => params[:username], :password => params[:password], :pass_confirm => params[:pass_confirm])
      session[:user_id] = @user.id
      redirect '/lists'
    end
  end

  # get '/login' do
  #   if !logged_in?
  #     erb :'users/login'
  #   else
  #     redirect '/lists'
  #   end
  # end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{current_user.username}!"
      redirect '/lists'
    else
      flash[:notice] = "Username and password do not match. Please try again. "
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/'
    end
  end

end

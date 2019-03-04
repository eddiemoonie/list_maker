class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_users'
    else
      redirect '/lists'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/lists'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/lists'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/lists'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

end

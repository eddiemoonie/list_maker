class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_users'
    else
      redirect '/todos'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/todos'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/todos'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:username])
      session[:user_id] = user.id
      redirect '/todos'
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

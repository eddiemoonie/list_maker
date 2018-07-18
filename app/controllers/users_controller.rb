class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_users'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = user.id
      redirect '/todos'
    end
  end

end

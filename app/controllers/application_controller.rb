require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    register Sinatra::Flash
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "weeklytodolist"
  end

  get '/' do
    if logged_in?
      redirect '/lists'
    else
      erb :index
    end
  end

  helpers do

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end
end

class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_users'
    end
  end

end

class TodosController < ApplicationController

  get '/todos' do
    if logged_in?
      @todos = Todos.all
      erb :'todos/todos'
    else
      redirect '/login'
    end
  end
end

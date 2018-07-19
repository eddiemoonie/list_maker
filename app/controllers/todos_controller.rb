class TodosController < ApplicationController

  get '/todos' do
    if logged_in?
      @todos = Todos.all
      erb :'todos/todos'
    else
      redirect '/login'
    end
  end

  get '/todos/new' do
    if logged_in?
      erb :'todos/create_todo'
    else
      redirect '/login'
    end
  end

  post '/todos' do
    if logged_in?
      if params[:day] == "" || params[:description] == ""
        redirect "/todos/new"
      else
        @todo = current_user.todos.build(:day => params[:day], :description => params[:description])
        if @todo.save
          redirect "/todos/#{@todo.id}"
        else
          redirect "/todos/new"
        end
      end
    else
      redirect '/login'
    end
  end
end

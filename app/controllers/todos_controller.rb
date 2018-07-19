class TodosController < ApplicationController

  get '/todos' do
    if logged_in?
      @todos = Todo.all
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

  get '/todos/:id' do
    if logged_in?
      @todo = Todo.find_by_id(params[:id])
      erb :'/todos/show_todo'
    else
      redirect '/login'
    end
  end

  get '/todos/:id/edit' do
    if logged_in?
      @todo = Todo.find_by_id(params[:id])
      if @todo && @todo.user == current_user
        erb :'todos/edit_todo'
      else
        redirect '/todos'
      end
    else
      redirect '/login'
    end
  end

  patch '/todos/:id' do
    if logged_in?
      if params[:description] == ""
        redirect "/todos/#{params[:id]}/edit"
      else
        @todo = Todo.find_by_id(params[:id])
        if @todo && @todo.user == current_user
          if @todo.update(:day => params[:day], :description => params[:description])
            redirect "/todos/#{@todo.id}"
          else
            redirect "/tweets/#{@todo.id}/edit"
          end
        else
          redirect '/todos'
        end
      end
    else
      redirect '/login'
    end
  end

  delete '/todos/:id/delete' do
    if logged_in?
      @todo = Todo.find_by_id(params[:id])
      if @todo && @todo.user == current_user
        @todo.delete
      end
      redirect '/todos'
    else
      redirect '/login'
    end
  end
end

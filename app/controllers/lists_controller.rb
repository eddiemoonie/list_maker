class ListsController < ApplicationController

  get '/lists' do
    if logged_in?
      @lists = List.select{|list| list.user_id == session[:user_id]}
      erb :'lists/lists'
    else
      redirect '/login'
    end
  end

  get '/lists/new' do
    if logged_in?
      erb :'lists/create_list'
    else
      redirect '/login'
    end
  end

  post '/lists' do
    if logged_in?
      if params[:name] == ""
        redirect "/lists/new"
      else
        @list = current_user.lists.build(:name => params[:name])
        if @list.save
          redirect "/lists/#{@list.id}"
        else
          redirect "/lists/new"
        end
      end
    else
      redirect '/login'
    end
  end

  get '/lists/:id' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      erb :'/lists/show_list'
    else
      redirect '/login'
    end
  end

  post '/lists/:id' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if params[:description] == ""
        redirect "/lists/#{@list.id}"
      else
        @task = @list.tasks.build(:description => params[:description])
        if @task.save
          redirect "/lists/#{@list.id}"
        else
          redirect "/lists/#{@list.id}"
        end
      end
    else
      redirect '/login'
    end
  end

  get '/lists/:id/edit' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if @list && @list.user == current_user
        erb :'lists/edit_list'
      else
        redirect '/lists'
      end
    else
      redirect '/login'
    end
  end

  patch '/lists/:id' do
    if logged_in?
      if params[:description] == ""
        redirect "/lists/#{params[:id]}/edit"
      else
        @list = List.find_by_id(params[:id])
        if @list && @list.user == current_user
          if @list.update(:name => params[:name])
            redirect "/lists/#{@list.id}"
          else
            redirect "/lists/#{@list.id}/edit"
          end
        else
          redirect '/lists'
        end
      end
    else
      redirect '/login'
    end
  end

  delete '/lists/:id/delete' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if @list && @list.user == current_user
        @list.delete
      end
      redirect '/lists'
    else
      redirect '/login'
    end
  end
end

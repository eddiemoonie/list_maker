class ListsController < ApplicationController

  get '/lists' do
    if logged_in?
      @lists = List.select{|list| list.user_id == session[:user_id]}
      erb :'lists/lists'
    else
      redirect '/login'
    end
  end

  # get '/lists/new' do
  #   if logged_in?
  #     erb :'lists/create_list'
  #   else
  #     redirect '/login'
  #   end
  # end

  post '/lists' do
    if logged_in?
      if params[:name] == ""
        flash[:notice] = "Please enter list name."
        redirect "/lists/new"
      else
        @list = current_user.lists.build(:name => params[:name])
        if @list.save
          flash[:notice] = "#{@list.name} list has been successfully created."
          redirect "/lists/#{@list.id}"
        else
          redirect "/lists/#{@list.id}"
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
        flash[:notice] = "Please enter item."
        redirect "/lists/#{@list.id}"
      else
        @item = @list.items.build(:description => params[:description], :user_id => current_user.id)
        if @item.save
          flash[:notice] = "Item has been added to list."
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
      if params[:name] == ""
        flash[:notice] = "Please enter list name."
        redirect "/lists/#{params[:id]}/edit"
      else
        @list = List.find_by_id(params[:id])
        if @list && @list.user == current_user
          if @list.update(:name => params[:name])
            flash[:notice] = "List name has been updated."
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
      flash[:notice] = "List has been deleted."
      redirect '/lists'
    else
      redirect '/login'
    end
  end

end

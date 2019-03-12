class ItemsController < ApplicationController

  delete '/items/:id/delete' do
    if logged_in?
      @item = Item.find_by_id(params[:id])
      list_id = @item.list_id
      if @item && @item.user == current_user
        @item.delete
      end
      flash[:notice] = "Item has been deleted."
      redirect "/lists/#{list_id}"
    else
      redirect '/login'
    end
  end

end

  # get '/tasks/new' do
  #   if logged_in?
  #     @list = List.find_by_id(params[:id])
  #     erb :'tasks/create_task'
  #   else
  #     redirect '/login'
  #   end
  # end
  #
  # post '/lists/:id' do
  #   if logged_in?
  #     @list = List.find_by_id(params[:id])
  #     if params[:description] == ""
  #       redirect "/lists/#{@list.id}"
  #     else
  #       @task = @list.tasks.build(:description => params[:description])
  #       if @task.save
  #         redirect "/lists/#{@list.id}"
  #       else
  #         redirect "/lists/#{@list.id}"
  #       end
  #     end
  #   else
  #     redirect '/login'
  #   end
  # end

class TasksController < ApplicationController

  # get '/tasks/new' do
  #   if logged_in?
  #     @list = List.find_by_id(params[:id])
  #     erb :'tasks/create_task'
  #   else
  #     redirect '/login'
  #   end
  # end

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

end

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

class HomesController < ApplicationController
  before_action :authenticate_user!, except: :top

  def top
    @items = Item.page(params[:page]).per(4)
    @genres = Genre.all
  end

def about

end

end
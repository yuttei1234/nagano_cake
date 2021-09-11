class Public::HomesController < ApplicationController

def top
  @genres = Genre.where(id: params[:id])
  @random = Item.order("RAND()").limit(4)
   
end

def about
end

end
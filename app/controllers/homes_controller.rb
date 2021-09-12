class HomesController < ApplicationController

def top
  @genres = Genre.all
end

def about
  @random = Item.order("RAND()").limit(4)
end

end
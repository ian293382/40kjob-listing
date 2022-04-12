class FavoritesController < ApplicationController
    def index
     @jobs = current_user.favorite_jobs
   end
end

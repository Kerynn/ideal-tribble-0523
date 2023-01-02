class MovieActorsController < ApplicationController

  def create 
    movie = Movie.find(params[:id])
    actor = Actor.find(params[:actor_id])
    MovieActor.create!(movie_id: movie.id, actor_id: actor.id)
    redirect_to "/movies/#{movie.id}"
  end
end
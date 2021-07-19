
class MovieActorsController < ApplicationController
  def new
    @actor = Actor.new
  end

  def create
    @movie = Movie.find(params[:id])
    @actor = @movie.actors.create!(actor_params)

    @actor.save

    redirect_to "/movies/#{@movie.id}"
  end

  private

  def actor_params
    params.permit(:name, :age)
  end
end

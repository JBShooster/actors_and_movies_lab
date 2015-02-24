class ActorsController < ApplicationController
  def index
    @actors = Actor.all
  end

  def create
    form_data = params.require(:actor).permit(:name)
    Actor.create form_data
    redirect_to actors_path
  end

  def new
    @actor = Actor.new
  end

  def edit
    @actor = Actor.find(params[:id])
  end

  def show
    @actor = Actor.find(params[:id])
    @movies = Movie.all - @actor.movies
  end

  def update
    form_data = params.require(:actor).permit(:name)
    actor = Actor.find(params[:id])
    actor.update_attributes form_data
    redirect_to actor_path(actor)
  end

  def destroy
    actor = Actor.find(params[:id])
    actor.destroy
    redirect_to actors_path
  end

  def add_movie
    movie = Movie.find(params[:id])
    actor = Actor.find(params[:id])
    unless actor.movies.include? movie
      actor.movies << movie
    end
    redirect_to actor_path(actor)
  end

  def remove_movie
    movie = Movie.find(params[:id])
    actor = Actor.find(params[:id])
    actor.movies.destroy(movie)
    redirect_to actors_path(@actor)
  end
end

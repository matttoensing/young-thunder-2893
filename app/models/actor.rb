class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def coactors
    self.movie_actors.select("actors.id")
    Actor.includes(:movie_actors).references(:moviess).where('application_id = ?')
  end
end

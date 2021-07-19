class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def order_actors_by_age
    self.actors.order(:age)
  end

  def average_age_of_actors
    self.actors.average(:age).to_i
  end
end

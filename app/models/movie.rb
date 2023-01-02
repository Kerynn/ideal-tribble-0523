class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def sort_actors
    actors.order(:age)
  end

  def average_age_of_actors
    if actors.empty?
      0
    else
      actors.average(:age).round(2)
    end 
  end
end

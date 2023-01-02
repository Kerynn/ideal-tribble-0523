require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :movie_actors}
    it {should have_many(:actors).through(:movie_actors)}
  end

  describe "sort_actors" do
    it "sorts all the actors of the movie from youngest to oldest" do
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
      jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")

      jeff = Actor.create!(name: "Jeff Goldblum", age: 70)
      laura = Actor.create!(name: "Laura Dern", age: 55)
      sam = Actor.create!(name: "Sam Neill", age: 75)

      MovieActor.create!(movie_id: jurassic_park.id, actor_id: jeff.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: laura.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: sam.id)

      expect(jurassic_park.sort_actors).to eq([laura, jeff, sam])
    end
  end
end

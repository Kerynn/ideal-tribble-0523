require 'rails_helper'

RSpec.describe 'Movies' do
  describe 'when I visit a movie show page' do
    it 'shows the movie title, creation year, and genre' do
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
      jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")

      visit "/movies/#{jurassic_park.id}"

      expect(page).to have_content(jurassic_park.title)
      expect(page).to have_content("Creation Year: #{jurassic_park.creation_year}")
      expect(page).to have_content("Genre: #{jurassic_park.genre}")
    end

    it 'lists all the actors from youngest to oldest' do
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
      jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")

      jeff = Actor.create!(name: "Jeff Goldblum", age: 70)
      laura = Actor.create!(name: "Laura Dern", age: 55)
      sam = Actor.create!(name: "Sam Neill", age: 75)

      MovieActor.create!(movie_id: jurassic_park.id, actor_id: jeff.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: laura.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: sam.id)

      visit "/movies/#{jurassic_park.id}"

      expect(laura.name).to appear_before(jeff.name)
      expect(jeff.name).to appear_before(sam.name)
      expect(laura.name).to appear_before(sam.name)
    end

    it "shows the average age of all the movie's actors" do

    end
  end
end
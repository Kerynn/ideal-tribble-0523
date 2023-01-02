require 'rails_helper'

RSpec.describe "studios show page" do
  describe 'when I visit the studio show page' do 
    it 'shows the studio name and location' do
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")

      visit "/studios/#{universal.id}"

      expect(page).to have_content(universal.name)
      expect(page).to have_content("Studio Location: #{universal.location}")
    end

    xit "shows a unique list of all actors that have worked on any of the studio's movies" do
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")

      jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")
      harry_potter = universal.movies.create!(title: "Harry Potter and the Sorceror's Stone", creation_year: "1998", genre: "Fantasy")

      jeff = Actor.create!(name: "Jeff Goldblum", age: 70)
      laura = Actor.create!(name: "Laura Dern", age: 55)
      sam = Actor.create!(name: "Sam Neill", age: 75)

      MovieActor.create!(movie_id: jurassic_park.id, actor_id: jeff.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: laura.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: sam.id)

      daniel = Actor.create!(name: "Daniel Radcliffe", age: 33)
      emma = Actor.create!(name: "Emma Watson", age: 32)
      rupert = Actor.create!(name: "Rupert Grint", age: 34)

      MovieActor.create!(movie_id: harry_potter.id, actor_id: daniel.id)
      MovieActor.create!(movie_id: harry_potter.id, actor_id: emma.id)
      MovieActor.create!(movie_id: harry_potter.id, actor_id: rupert.id)

      visit "/studios/#{universal.id}"

      within "#studio_movie_actors" do
        expect(page).to have_content(jeff.name)
        expect(page).to have_content(laura.name)
        expect(page).to have_content(sam.name)
        expect(page).to have_content(daniel.name)
        expect(page).to have_content(emma.name)
        expect(page).to have_content(rupert.name)
      end 
    end
  end
end
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
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
      jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")

      jeff = Actor.create!(name: "Jeff Goldblum", age: 70)
      laura = Actor.create!(name: "Laura Dern", age: 55)
      sam = Actor.create!(name: "Sam Neill", age: 75)

      MovieActor.create!(movie_id: jurassic_park.id, actor_id: jeff.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: laura.id)
      MovieActor.create!(movie_id: jurassic_park.id, actor_id: sam.id)

      visit "/movies/#{jurassic_park.id}"

      expect(page).to have_content("Average Age of Actors: 66.67")
    end
  end

  describe "adding an actor to a movie" do
    describe "when I visit the movie show page" do
      it 'does not show actors that are not part of the movie' do
        universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
        jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")
  
        jeff = Actor.create!(name: "Jeff Goldblum", age: 70)
        laura = Actor.create!(name: "Laura Dern", age: 55)
        sam = Actor.create!(name: "Sam Neill", age: 75)
        samuel = Actor.create!(name: "Samuel L. Jackson", age: 74)
        wayne = Actor.create!(name: "Wayne Knight", age: 67)

        MovieActor.create!(movie_id: jurassic_park.id, actor_id: jeff.id)
        MovieActor.create!(movie_id: jurassic_park.id, actor_id: laura.id)
        MovieActor.create!(movie_id: jurassic_park.id, actor_id: sam.id)
  
        visit "/movies/#{jurassic_park.id}"

        expect(page).to_not have_content(samuel.name)
        expect(page).to_not have_content(wayne.name)
      end

      it 'will have a form to add an actor to this movie' do
        universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
        jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")
  
        jeff = Actor.create!(name: "Jeff Goldblum", age: 70)
        laura = Actor.create!(name: "Laura Dern", age: 55)
        sam = Actor.create!(name: "Sam Neill", age: 75)
        samuel = Actor.create!(name: "Samuel L. Jackson", age: 74)

        MovieActor.create!(movie_id: jurassic_park.id, actor_id: jeff.id)
        MovieActor.create!(movie_id: jurassic_park.id, actor_id: laura.id)
        MovieActor.create!(movie_id: jurassic_park.id, actor_id: sam.id)
  
        visit "/movies/#{jurassic_park.id}"

        fill_in :actor_id, with: samuel.id
        expect(page).to have_button("Add Actor to Movie")
      end

      it 'will show the new actor listed on the movie show page once submit the form' do
        universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
        jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")
  
        jeff = Actor.create!(name: "Jeff Goldblum", age: 70)
        laura = Actor.create!(name: "Laura Dern", age: 55)
        sam = Actor.create!(name: "Sam Neill", age: 75)
        samuel = Actor.create!(name: "Samuel L. Jackson", age: 74)

        MovieActor.create!(movie_id: jurassic_park.id, actor_id: jeff.id)
        MovieActor.create!(movie_id: jurassic_park.id, actor_id: laura.id)
        MovieActor.create!(movie_id: jurassic_park.id, actor_id: sam.id)
  
        visit "/movies/#{jurassic_park.id}"

        expect(page).to_not have_content(samuel.name)

        fill_in :actor_id, with: samuel.id
        click_button "Add Actor to Movie"

        expect(current_path).to eq("/movies/#{jurassic_park.id}")
        expect(page).to have_content(samuel.name)
      end
    end
  end
end
require 'rails_helper'

RSpec.describe 'Studios' do
  describe 'when I visit the studio index page' do
    it 'lists all the studios names and locations' do
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
      disney = Studio.create!(name: "Disney Studios", location: "Orlando")
      pixar = Studio.create!(name: "Pixar Studios", location: "Hollywood")

      visit "/studios"

      expect(page).to have_content("Studio: #{universal.name}")
      expect(page).to have_content("Location: #{universal.location}")
      expect(page).to have_content("Studio: #{disney.name}")
      expect(page).to have_content("Location: #{disney.location}")
      expect(page).to have_content("Studio: #{pixar.name}")
      expect(page).to have_content("Location: #{pixar.location}")
    end

    it 'lists all the movie attributes that belong to each studio' do
      universal = Studio.create!(name: "Universal Studios", location: "Hollywood")
      harry_potter = universal.movies.create!(title: "Harry Potter and the Sorceror's Stone", creation_year: "1998", genre: "Fantasy")
      jurassic_park = universal.movies.create!(title: "Jurassic Park", creation_year: "1993", genre: "Dinosaurs")

      disney = Studio.create!(name: "Disney Studios", location: "Orlando")
      bambi = disney.movies.create!(title: "Bambi", creation_year: "1980", genre: "Animation")
      
      pixar = Studio.create!(name: "Pixar Studios", location: "Hollywood")
      toy_story = pixar.movies.create!(title: "Toy Story", creation_year: "1995", genre: "Animation")
      coco = pixar.movies.create!(title: "Coco", creation_year: "2017", genre: "Animation")

      visit "/studios"

      within "#studio_#{universal.id}" do
        expect(page).to have_content(harry_potter.title)
        expect(page).to have_content(harry_potter.creation_year)
        expect(page).to have_content(harry_potter.genre)
        expect(page).to have_content(jurassic_park.title)
        expect(page).to have_content(jurassic_park.creation_year)
        expect(page).to have_content(jurassic_park.genre)
        expect(page).to_not have_content(bambi.title)
        expect(page).to_not have_content(coco.title)
      end

      within "#studio_#{disney.id}" do
        expect(page).to have_content(bambi.title)
        expect(page).to have_content(bambi.creation_year)
        expect(page).to have_content(bambi.genre)
        expect(page).to_not have_content(jurassic_park.title)
        expect(page).to_not have_content(coco.title)
      end

      within "#studio_#{pixar.id}" do
        expect(page).to have_content(toy_story.title)
        expect(page).to have_content(toy_story.creation_year)
        expect(page).to have_content(toy_story.genre)
        expect(page).to have_content(coco.title)
        expect(page).to have_content(coco.creation_year)
        expect(page).to have_content(coco.genre)
        expect(page).to_not have_content(bambi.title)
        expect(page).to_not have_content(harry_potter.title)
      end 
    end
  end
end
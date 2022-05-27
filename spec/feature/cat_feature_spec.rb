require 'helpers/database_helpers'
require 'cat_entity'
require 'cats_table'

RSpec.describe "Lost cat board feature tests", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("cats_table")
  end
    
  it "starts with an empty board" do
    visit '/lostcats' 
    expect(page).to have_content "There are no lost kitty catters. Congrats!"
  end

  it "adds a cat and is displayed on the board" do
    visit '/lostcats' 
    click_button "Add a lost cat"
    fill_in "name", with: "Garfield" 
    fill_in "phone", with: "01225 587 123"
    fill_in "description", with: "An apathetic being"
    fill_in "password", with: "poorjohn"
    click_button "Add"
    click_button "Add a lost cat"
    fill_in "name", with: "Thor" 
    fill_in "phone", with: "08223 523 089"
    fill_in "description", with: "A big skoggkatt last seen hanging out with vikings"
    fill_in "password", with: "landoficeandsnow"
    click_button "Add"
    expect(page).to have_content "Garfield" 
    expect(page).to have_content "01225 587 123"
    expect(page).to have_content "An apathetic being"
    expect(page).to have_content "Thor" 
    expect(page).to have_content "08223 523 089"
    expect(page).to have_content "A big skoggkatt last seen hanging out with vikings"
  end

  it "adds and displays multiple cats on the board" do
    visit '/lostcats' 
    click_button "Add a lost cat"
    fill_in "name", with: "Garfield" 
    fill_in "phone", with: "01225 587 123"
    fill_in "description", with: "An apathetic being"
    fill_in "password", with: "poorjohn"
    click_button "Add"
    click_button "Add a lost cat"
    fill_in "name", with: "Thor" 
    fill_in "phone", with: "08223 523 089"
    fill_in "description", with: "A big skoggkatt last seen hanging out with vikings"
    fill_in "password", with: "landoficeandsnow"
    click_button "Add"
    expect(page).to have_content "Garfield" 
    expect(page).to have_content "01225 587 123"
    expect(page).to have_content "An apathetic being"
    expect(page).to have_content "Thor" 
    expect(page).to have_content "08223 523 089"
    expect(page).to have_content "A big skoggkatt last seen hanging out with vikings"
  end

  context "If existing cats have been added" do
    it "a cat instance can be edited" do
      visit '/lostcats' 
      click_button "Add a lost cat"
      fill_in "name", with: "Tiny" 
      fill_in "phone", with: "014245 2398 234"
      fill_in "description", with: "A bobcat that has wandered down from the mountains"
      fill_in "password", with: "mountainman"
      click_button "Add"
      click_button "Add a lost cat"
      fill_in "name", with: "Tom" 
      fill_in "phone", with: "04123 9785 121"
      fill_in "description", with: "A cartoon cat lost to the mists of time"
      fill_in "password", with: "notamouser"
      click_button "Add"
      expect(page).to have_content "Tiny" 
      expect(page).to have_content "014245 2398 234"
      expect(page).to have_content "A bobcat that has wandered down from the mountains"
      expect(page).to have_content "Tom" 
      expect(page).to have_content "04123 9785 121"
      expect(page).to have_content "A cartoon cat lost to the mists of time"
      click_button "edit 1"
      fill_in "name", with: "Nibbler" 
      fill_in "phone", with: "01325 239 051"
      fill_in "description", with: "A black & white cat with sharp teeth and antenna"
      fill_in "password", with: "notamouser"
      click_button "Submit"
      expect(page).to have_content "Nibbler"
      expect(page).to have_content "01325 239 051"
      expect(page).to have_content "A black & white cat with sharp teeth and antenna"
      expect(page).to have_content "Tiny" 
      expect(page).to have_content "014245 2398 234"
      expect(page).to have_content "A bobcat that has wandered down from the mountains"
    end

    it "a cat instance can be deleted" do
      visit '/lostcats' 
      click_button "Add a lost cat"
      fill_in "name", with: "Tiny" 
      fill_in "phone", with: "014245 2398 234"
      fill_in "description", with: "A bobcat that has wandered down from the mountains"
      fill_in "password", with: "mountainman"
      click_button "Add"
      click_button "Add a lost cat"
      fill_in "name", with: "Tom" 
      fill_in "phone", with: "04123 9785 121"
      fill_in "description", with: "A cartoon cat lost to the mists of time"
      fill_in "password", with: "notamouser"
      click_button "Add"
      expect(page).to have_content "Tiny" 
      expect(page).to have_content "014245 2398 234"
      expect(page).to have_content "A bobcat that has wandered down from the mountains"
      expect(page).to have_content "Tom" 
      expect(page).to have_content "04123 9785 121"
      expect(page).to have_content "A cartoon cat lost to the mists of time"
      click_button "delete 0"
      expect(page).not_to have_content "Tiny" 
      expect(page).not_to have_content "014245 2398 234"
      expect(page).not_to have_content "A bobcat that has wandered down from the mountains"
      expect(page).to have_content "Tom" 
      expect(page).to have_content "04123 9785 121"
      expect(page).to have_content "A cartoon cat lost to the mists of time"
    end
  end

  context "For an existing single cat instance" do
    it "sightings can be added to the advert" do
      visit '/lostcats' 
      click_button "Add a lost cat"
      fill_in "name", with: "Vlad" 
      fill_in "phone", with: "06660 666 606"
      fill_in "description", with: "Vlad is out for blood"
      fill_in "password", with: "nogarlicplease"
      click_button "Add"
      expect(page).to have_content "Vlad" 
      expect(page).to have_content "06660 666 606"
      expect(page).to have_content "Vlad is out for blood"
      click_button "Add a sighting for Vlad"
      expect(page).to have_content "There are no sightings for Vlad"
      click_button ""
      fill_in "sighting", with: "I saw Vlad by the graveyard"
      click_button "submit"
      expect(page).to have_content "Vlad" 
      expect(page).to have_content "06660 666 606"
      expect(page).to have_content "Vlad is out for blood"
      expect(page).to have_content "I saw Vlad by the graveyard"
    end
  end

end

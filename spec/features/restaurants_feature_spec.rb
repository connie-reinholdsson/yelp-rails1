require 'rails_helper'


feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    scenario 'display restaurants' do
      sign_up
      create_restaurant
      visit '/restaurants'
      expect(page).to have_content 'Silky Salmon'
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Avocado in Paradise'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Avocado in Paradise'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    scenario 'lets a user view a restaurant' do
      sign_up
      create_restaurant(name: 'Avocado in Paradise')
      visit '/restaurants'
      click_link 'Show Avocado in Paradise'
      expect(page).to have_content 'Avocado in Paradise'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      sign_up
      create_restaurant(name: 'Avocado in Paradise')
      visit root_path
      click_link 'Edit Avocado in Paradise'
      fill_in 'Name', with: "Avolicious"
      fill_in 'Description', with: "Only the perfectly ripe"
      click_button 'Update Restaurant'
      click_link 'Show Avolicious'
      expect(page).to have_content "Avolicious"
      expect(page).to have_content "Only the perfectly ripe"
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'deleting restaurants' do
    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up
      create_restaurant
      visit root_path
      click_link 'Delete Silky Salmon'
      expect(page).not_to have_content 'Silky Salmon'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'an invalid restaurant' do
    scenario 'does not let you submit a name that is too short' do
      sign_up
      visit root_path
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'ky'
      click_button 'Create Restaurant'
      expect(page).not_to have_content 'ky'
      expect(page).to have_content ''
    end
  end

  context 'user signed in' do
   scenario 'able to create a restaurant' do
     visit root_path
     click_link 'Add a restaurant'
     expect(current_path).to eq '/users/sign_in'
     expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end

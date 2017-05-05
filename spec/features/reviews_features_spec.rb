require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Avocado in Paradise'}

  scenario 'allows users to leave a review using a form' do
    sign_up
    create_restaurant
    visit root_path
    click_link 'Review Silky Salmon'
    fill_in "Thoughts", with: "AMAZIIIIIING"
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    click_link 'All reviews'
    expect(page).to have_content 'AMAZIIIIIING'
  end
end

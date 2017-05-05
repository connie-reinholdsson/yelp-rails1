module SessionHelpers

  def sign_up
    visit '/restaurants'
    click_link 'Sign up'
    expect(current_path).to eq '/users/sign_up'
    fill_in 'Email', with: 'seal@pacificocean.com'
    fill_in 'Password', with: 'ilovesalmon'
    fill_in 'Password confirmation', with: 'ilovesalmon'
    click_button 'Sign up'
  end

  def create_restaurant(name: 'Silky Salmon')
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    fill_in 'Description', with: 'Best salmon in the ocean'
    click_button 'Create Restaurant'
  end

end

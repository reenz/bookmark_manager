feature 'creating links' do
  scenario 'can create link and submit'do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.reena_webpage.com/'
    fill_in 'title', with: 'Welcome!'
    click_button 'Create link'

    expect(current_path).to eq '/links'
    within 'ul#links'do
      expect(page).to have_content('Welcome')
     end
  end
end

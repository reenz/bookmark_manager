feature 'Adding tags' do
  scenario 'add tags to the links'do
    visit('/links/new')
    fill_in 'url',   with: 'www.google.com'
    fill_in 'title', with: 'google'
    fill_in 'tag', with: "search engine"
    click_button 'Create link'

    expect(page).to have_content 'search engine'
  end
end

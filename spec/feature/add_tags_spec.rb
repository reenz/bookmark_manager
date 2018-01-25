feature 'Adding tags' do
  scenario 'add tags to the links'do
    visit('/links/new')
    fill_in 'url',   with: 'www.google.com'
    fill_in 'title', with: 'google'
    fill_in 'tags', with: "search_engine"
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('search_engine')
  end

  scenario 'filter links by a tag' do
     Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'Search Engine')])
     Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])

     visit('/tags/education')
     expect(page).to have_content('makers')

  end

  scenario 'I can add multiple tags to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags',  with: 'education ruby'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
end

end

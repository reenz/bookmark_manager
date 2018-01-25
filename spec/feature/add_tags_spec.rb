feature 'Adding tags' do
  scenario 'add tags to the links'do
    visit('/links/new')
    fill_in 'url',   with: 'www.google.com'
    fill_in 'title', with: 'google'
    fill_in 'tag', with: "search engine"
    click_button 'Create link'

    #expect(page).to have_content 'search engine'
    link = Link.first
    expect(link.tags.map(&:name)).to include('search engine')
  end

  scenario 'filter links by a tag' do
     Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'Search Engine')])
     Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])

    visit('/tags/education')
    expect(page).to have_content('makers')

  end
end

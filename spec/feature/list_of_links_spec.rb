
feature 'viewing list of links' do
  scenario 'can see list of links' do
     Link.create(url: 'http://www.reena.com', title:'Reena')
     visit'/links'
     expect(page.status_code).to eq 200
     within 'ul#links' do
      expect(page).to have_content('Reena')
    end
  end
end

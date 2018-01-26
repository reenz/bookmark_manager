def sign_up
  visit('/users/new')
  expect(page.status_code).to eq 200
  fill_in :email, with: 'reena@example.com'
  fill_in :password, with: 'password12'
  click_button 'Sign up'
end

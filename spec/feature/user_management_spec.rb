feature 'User sign up'do
  scenario 'I can sign up as new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content ('Welcome, reena@example.com')
    expect(User.first.email).to eq ('reena@example.com')
  end
end
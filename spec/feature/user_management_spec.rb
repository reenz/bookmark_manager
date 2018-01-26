feature 'User sign up'do
  scenario 'I can sign up as new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content ('Welcome, reena@example.com')
    expect(User.first.email).to eq ('reena@example.com')
  end

  scenario 'password confirmation' do
    expect { sign_up(password_confirmation: 'password') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end
end

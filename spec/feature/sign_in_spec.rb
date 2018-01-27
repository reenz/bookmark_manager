feature  'User sign in' do
  let!(:user) do
    User.create(email: 'user@example.com',password: 'password',
    password_confirmation: 'password')
  end

  def sign_in(email:, password:)
    visit('sessions/new')
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end

  scenario 'with correct credentials' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end
end

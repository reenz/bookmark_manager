feature 'Resetting Password' do

  before do
    sign_up
    Capybara.reset!
  end

  let(:user) { User.first }

  def recover_password
    visit '/users/recover'
    fill_in :email, with: "reena@example.com"
    click_button "Submit"
  end

  def set_password(password:, password_confirmation:)
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button "Submit"
  end

 scenario 'When user forget password user can see a link to reset' do
   visit '/sessions/new'
   click_link 'I forgot my password'
   expect(page).to have_content("Please enter your email address")
 end

 scenario 'When user enter email they are told to check there inbox' do
   recover_password
   expect(page).to have_content "Thanks, Please check your inbox for the link."
 end

 scenario 'it doesn\'t allow user to use the token after an hour' do
    recover_password
    Timecop.travel(60 * 60 * 60) do
      visit("/users/reset_password?token=#{user.password_token}")
      expect(page).to have_content "Your token is invalid"
    end
  end

  scenario 'it asks for new password when token is valid' do
     recover_password
     visit("/users/reset_password?token=#{user.password_token}")
     expect(page).to have_content("Please enter your new password")
  end

  scenario 'it lets user enter a new password with a valid token' do
    recover_password
    set_password(password: "newpassword", password_confirmation: "newpassword")
    expect(page).to have_content("Please sign in")
  end

  scenario 'it lets you sign in after password reset' do
     recover_password
     set_password(password: "newpassword", password_confirmation: "newpassword")
     sign_in(email: "reena@example.com", password: "newpassword")
     expect(page).to have_content "Welcome, reena@example.com"
   end

   scenario 'it lets user know if their passwords don\'t match' do
     recover_password
     visit("/users/reset_password?token=#{user.password_token}")
     fill_in :password, with: "newpassword"
     fill_in :password_confirmation, with: "wrongpassword"
     click_button "Submit"
     expect(page).to have_content("Password does not match the confirmation")
   end

   scenario 'it immediately resets token upon successful password update' do
    recover_password
    set_password(password: "newpassword", password_confirmation: "newpassword")
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content("Your token is invalid")
  end

end

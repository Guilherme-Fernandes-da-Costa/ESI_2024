# Auto-login a test user before each scenario so steps that require authentication can run
Before do
  # Create or reuse a default test user
  @auto_user ||= FactoryBot.create(:user, email: "cuke_user@example.com")
  visit login_path
  fill_in 'Email', with: @auto_user.email
  fill_in 'Password', with: @auto_user.password
  click_button 'Entrar'
end

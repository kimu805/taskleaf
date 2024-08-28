module SignInSupport
  def sign_in(user)
    visit login_path
    fill_in "メールアドレス", with: @user.email
    fill_in "パスワード", with: @user.password
    click_on "ログインする"
  end
end
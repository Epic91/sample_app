require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "login with invalid information" do
    get login_path #visit the login path
    assert_template 'sessions/new' #verify that the new sessions form renders properly
    post login_path, session: { email: "", password: "" } #post to the sessions path with an invalid params hash
    assert_template 'sessions/new' #verify that the new sessiosn form gets re rendered and that a flash message appears
    assert_not flash.empty?
    get root_path #visit another page
    assert flash.empty? #verify that the flash message doesnt appear on the new page
  end

  test "login with valid information followed by logout" do
    get login_path #visit the login path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user # check for the correct redirect target
    follow_redirect! # after checking for the redirect target actually visit the target page
    assert_template 'users/show' #verify that the users show form renders properly
    assert_select "a[href=?]", login_path, count: 0 # verifies that the login link disappears by verifying that there are zero login path links on the page
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path 
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    end
end

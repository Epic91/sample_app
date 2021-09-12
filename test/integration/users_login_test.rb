require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path #visit the login path
    assert_template 'sessions/new' #verify that the new sessions form renders properly
    post login_path, session: { email: "", password: "" } #post to the sessions path with an invalid params hash
    assert_template 'sessions/new' #verify that the new sessiosn form gets re rendered and that a flash message appears
    assert_not flash.empty?
    get root_path #visit another page
    assert flash.empty? #verify that the flash message doesnt appear on the new page
  end
end

require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # Test is failing it wont recognize user
  test "Invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
        name: "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    end
    assert_template 'users/new'
    assert_select 'div#<CSS id for error explanation>'
    assert_select 'div#CSS class for field with error'
  end

  # Test not working
  test "valid sign-up information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
        name: "Example User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end

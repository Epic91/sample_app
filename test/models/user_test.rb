require "test_helper"

class UserTest < ActiveSupport::TestCase
  # setup method automatically gets run before each test. @user is an instance variable and its automatically available in all tests.
  def setup
    @user = User.new(name: "Example User", email: "user@exmaple.com", password: "foobar", password_digest: "foobar")
  end
  # returns true if the user is valid
  test "should be valid" do
    assert @user.valid?
  end
  # sets the users name to a blank string and checks that the resulting USer object is not valid.
  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end
  #
  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end
  # if the name is 51 characters long this error will display
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  #for simplicity we user string concatination, if the characters in the email are 244 + the remaining .com characters display this message
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@bas.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

#run bundle exec rails test:models to run just the model tests

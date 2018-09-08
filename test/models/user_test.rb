require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should be less than 50 length" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should be less than 255 length" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be valid format" do
    invalid_emails = ['user@example,com',   # . -> ,
                      'user_at_foo.org',    # @ -> at
                      'user.name@example.', # many .
                      'foo@bar_baz.com',    # invalid _ 
                      'foo@bar+baz.com',    # invalid +
                      'foo@bar..com']       # invalid ..
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  test "password should be present" do
    @user.email = " " * 6
    assert_not @user.valid?
  end

  test "password should be longer than 6 length" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user       = @user.dup
    duplicate_user.email = @user.email.upcase # emailは大文字小文字区別しない設計
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email      = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

end

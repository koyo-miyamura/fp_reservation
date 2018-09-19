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
    @user.password_confirmation = "a" * 5
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

  test "associated reservations should be destroyed" do
    @user.save # destoryするにはsaveが必要
    fp = fps(:fp1)
    @user.reservations.create!(fp_id: fp.id, reserved_on: DateTime.now)
    assert_difference 'Reservation.count', -1 do
      @user.destroy
    end
  end

  test "should have many reservations" do
    reservation1 = @user.reservations.build(fp_id: 1, reserved_on: 10.minutes.ago)  
    reservation2 = @user.reservations.build(fp_id: 2, reserved_on: 10.minutes.ago)  
    assert @user.reservations.include?(reservation1)
    assert @user.reservations.include?(reservation2)
  end

  test "should have many reserving_fps" do
    user = users(:user1) # DBに登録されていないと2つ以上リレーションをたどるテスト通らない
    fp1  = fps(:fp1)
    fp2  = fps(:fp2)
    # buildでは2つ以上たどるリレーションが生成されない様子
    user.reservations.create(fp_id: fp1.id, reserved_on: 10.minutes.ago)  
    user.reservations.create(fp_id: fp2.id, reserved_on: 10.minutes.ago)  
    assert user.reserving_fps.include?(fp1)
    assert user.reserving_fps.include?(fp2)
  end

end

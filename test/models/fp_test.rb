require 'test_helper'

class FpTest < ActiveSupport::TestCase
  def setup
    @fp = Fp.new(name: "Example Fp", email: "fp@example.com",
                 password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @fp.valid?
  end

  test "name should be present" do
    @fp.name = "     "
    assert_not @fp.valid?
  end

  test "name should be less than 50 length" do
    @fp.name = "a" * 51
    assert_not @fp.valid?
  end

  test "email should be present" do
    @fp.email = "     "
    assert_not @fp.valid?
  end

  test "email should be less than 255 length" do
    @fp.email = "a" * 244 + "@example.com"
    assert_not @fp.valid?
  end

  test "email should be valid format" do
    invalid_emails = ['fp@example,com',   # . -> ,
                      'fp_at_foo.org',    # @ -> at
                      'fp.name@example.', # many .
                      'foo@bar_baz.com',  # invalid _ 
                      'foo@bar+baz.com',  # invalid +
                      'foo@bar..com']     # invalid ..
    invalid_emails.each do |invalid_email|
      @fp.email = invalid_email
      assert_not @fp.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  test "password should be present" do
    @fp.email = " " * 6
    assert_not @fp.valid?
  end

  test "password should be longer than 6 length" do
    @fp.password = "a" * 5
    assert_not @fp.valid?
  end

  test "email should be unique" do
    duplicate_fp       = @fp.dup
    duplicate_fp.email = @fp.email.upcase # emailは大文字小文字区別しない設計
    @fp.save
    assert_not duplicate_fp.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @fp.email        = mixed_case_email
    @fp.save
    assert_equal mixed_case_email.downcase, @fp.reload.email
  end

  test "associated reservations should be destroyed" do
    @fp.save # destoryするにはsaveが必要
    user = users(:user1)
    @fp.reservations.create!(user_id: user.id, reserved_on: 10.minutes.ago)
    assert_difference 'Reservation.count', -1 do
      @fp.destroy
    end
  end

  test "associated fp_reservable_times should be destroyed" do
    @fp.save # destoryするにはsaveが必要
    @fp.fp_reservable_times.create!(reservable_on: 10.minutes.ago)
    assert_difference 'FpReservableTime.count', -1 do
      @fp.destroy
    end
  end
  
  test "should have many reservations" do
    reservation1 = @fp.reservations.build(user_id: 1, reserved_on: 10.minutes.ago)  
    reservation2 = @fp.reservations.build(user_id: 2, reserved_on: 10.minutes.ago)  
    assert @fp.reservations.include?(reservation1)
    assert @fp.reservations.include?(reservation2)
  end

  test "should have many fp_reservable_times" do
    reservation1 = @fp.fp_reservable_times.build(reservable_on: 10.minutes.ago)  
    reservation2 = @fp.fp_reservable_times.build(reservable_on: 10.minutes.ago)  
    assert @fp.fp_reservable_times.include?(reservation1)
    assert @fp.fp_reservable_times.include?(reservation2)
  end

  test "should have many reserved_users" do
    fp = fps(:fp1) # DBに登録されていないと2つ以上リレーションをたどるテスト通らない
    user1 = users(:user1)
    user2 = users(:user2)
    # buildでは2つ以上たどるリレーションが生成されない様子
    fp.reservations.create(user_id: user1.id, reserved_on: 10.minutes.ago)  
    fp.reservations.create(user_id: user2.id, reserved_on: 10.minutes.ago)  
    assert fp.reserved_users.include?(user1)
    assert fp.reserved_users.include?(user2)
  end
end

require 'test_helper'

class FpReservableTimeTest < ActiveSupport::TestCase
  def setup
    @fp   = fps(:fp1)
    @fp_reservable_times = @fp.fp_reservable_times.build(
                    reservable_on: 10.minutes.ago)
  end

  test "should be valid" do
    assert @fp_reservable_times.valid?
  end

  test "should require a fp_id" do
    @fp_reservable_times.fp_id = nil
    assert_not @fp_reservable_times.valid?
  end

  test "should require a reservable_on" do
    @fp_reservable_times.reservable_on = nil
    assert_not @fp_reservable_times.valid?
  end

  test "should belong to fp" do
    assert_equal @fp, @fp_reservable_times.fp 
  end
end

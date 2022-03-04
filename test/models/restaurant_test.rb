require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @restaurant = restaurants(:one)
  end

  test "thumbs up" do
    @restaurant.thumbs_up
    assert_equal 8, @restaurant.will_split
    assert_equal 3, @restaurant.wont_split
  end

  test "thumbs down" do
    @restaurant.thumbs_down
    assert_equal 7, @restaurant.will_split
    assert_equal 4, @restaurant.wont_split
  end

  test "repeated thumbs up/down works" do
    @restaurant.thumbs_up
    @restaurant.thumbs_up
    @restaurant.thumbs_up
    @restaurant.thumbs_up
    @restaurant.thumbs_down
    @restaurant.thumbs_down
    @restaurant.thumbs_down
    assert_equal 11, @restaurant.will_split
    assert_equal 6, @restaurant.wont_split
  end
end

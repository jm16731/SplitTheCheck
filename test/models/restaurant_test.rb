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
    assert 8, @restaurant.will_split
  end

  test "thumbs down" do
    @restaurant.thumbs_up
    assert 6, @restaurant.will_split
  end
end

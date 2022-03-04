require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @restaurant = restaurants(:one)
  end

=begin
  def new_restaurant
    Restaurant.new(
        name: "Greg's Random Slop",
        location: "10 Falligant Ave",
        will_split: 1,
        wont_split: 0
  end
=end

  test "restaurant attributes must not be empty" do
    restaurant = Restaurant.new
    assert restaurant.invalid?
    assert restaurant.errors[:name].any?
    assert restaurant.errors[:location].any?
    assert restaurant.errors[:will_split].any?
    assert restaurant.errors[:wont_split].any?
  end

  test "restaurant splits cannot be negative" do
    restaurant = Restaurant.new(
        name: "Greg's Random Slop",
        location: "10 Falligant Ave",
        will_split: -1,
        wont_split: -1
      )

    assert restaurant.invalid?

    assert restaurant.errors[:will_split].any?
    assert_equal ["must be greater than or equal to 0"], restaurant.errors[:will_split]
    assert restaurant.errors[:wont_split].any?
    assert_equal ["must be greater than or equal to 0"], restaurant.errors[:wont_split]

    restaurant.will_split = 1
    restaurant.wont_split = 0

    assert restaurant.valid?
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

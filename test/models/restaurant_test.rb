require "test_helper"

class RestaurantTest < ActiveSupport::TestCase

  setup do
    @restaurant = restaurants(:joe)
    @paula = restaurants(:paula)

    @admin = users(:admin)
  end

  test "restaurant attributes must not be empty" do
    restaurant = Restaurant.new
    assert restaurant.invalid?
    assert restaurant.errors[:name].any?
    assert restaurant.errors[:location].any?
  end

  test "restaurant with attributes is good" do
    restaurant = Restaurant.new
    restaurant.name = "Wiley's"
    restaurant.location = "Highway 80"
    assert restaurant.valid?
  end

  test "new restaurant has 0 votes" do
    restaurant = Restaurant.new
    restaurant.name = "Wiley's"
    restaurant.location = "Highway 80"
    assert_equal 0, restaurant.vote.count
  end

  test "new restaurant with upvote has 1 upvote countt" do
    assert_equal 1, @restaurant.vote.where(votes: { split: true }).count
  end

  test "new restaurant with no downvotes has 0 downvote countt" do
    assert_equal 0, @restaurant.vote.where(votes: { split: false }).count
  end

  test "total_thumbs_up returns 1 upvote for new restaurant with upvote" do
    assert_equal 1, @restaurant.total_thumbs_up
  end

  test "total_thumbs_down returns 0 downvote for new restaurant with no downvote" do
    assert_equal 0, @restaurant.total_thumbs_down
  end

  test "total_thumbs_up returns 2 upvote for paula" do
    assert_equal 2, @paula.total_thumbs_up
  end

  test "total_thumbs_down returns 3 downvote for paula" do
    assert_equal 3, @paula.total_thumbs_down
  end

  test "create now paula downvote from admin does work" do
    @paula.vote.create!(
      split: false,
      user: @admin
    )
    assert_equal 4, @paula.total_thumbs_down
  end

  test "joe thumbs_up results in 2 upvotes" do
    @restaurant.thumbs_up(@admin)
    assert_equal 2, @restaurant.total_thumbs_up
  end

  test "joe thumbs_up thrice results in 4 upvotes" do
    @restaurant.thumbs_up(@admin)
    @restaurant.thumbs_up(@admin)
    @restaurant.thumbs_up(@admin)
    assert_equal 4, @restaurant.total_thumbs_up
  end

  test "paula thumbs_down results in 4 upvotes" do
    @paula.thumbs_down(@admin)
    assert_equal 4, @paula.total_thumbs_down
  end

  test "paula thumbs_down thrice results in 6 upvotes" do
    @paula.thumbs_down(@admin)
    @paula.thumbs_down(@admin)
    @paula.thumbs_down(@admin)
    assert_equal 6, @paula.total_thumbs_down
  end

  test "joe thumbs_up thrice thumbs_down twice results in 4 upvotes, 2 downvotes" do
    @restaurant.thumbs_up(@admin)
    @restaurant.thumbs_up(@admin)
    @restaurant.thumbs_up(@admin)
    @restaurant.thumbs_down(@admin)
    @restaurant.thumbs_down(@admin)
    assert_equal 4, @restaurant.total_thumbs_up
    assert_equal 2, @restaurant.total_thumbs_down
  end

=begin
  test "restaurant is valid if attributes exist and splits are non-negative" do
    restaurant = Restaurant.new(
        name: "Greg's Random Slop",
        location: "10 Falligant Ave",
        will_split: 1,
        wont_split: 0
      )
    assert restaurant.valid?
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
=end
end

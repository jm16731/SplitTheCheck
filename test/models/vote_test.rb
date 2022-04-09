require "test_helper"

class VoteTest < ActiveSupport::TestCase

  setup do
    @restaurant = Restaurant.create(name: "Wiley's", location: "Highway 80")
    @user = User.create(email: "testing@example.com", password: "aaaaaaaaaaa", password_confirmation: "aaaaaaaaaaa")
    @vote = Vote.create!(
      split: true,
      restaurant_id: @restaurant.id,
      user_id: @user.id
    )
  end

  test "vote attributes & references must not be empty" do
    vote = Vote.new
    assert vote.invalid?
    assert vote.errors[:split].any?
    assert_nil vote.restaurant_id
    assert_nil vote.user_id
    #assert vote.errors[:restaurant_id].any?
    #assert vote.errors[:user_id].any?
  end

  test "vote valid if have attributes & references" do
    vote = Vote.create!(
      split: true,
      restaurant_id: @restaurant.id,
      user_id: @user.id
    )
    assert vote.valid?

    vote = Vote.create!(
      split: false,
      restaurant_id: @restaurant.id,
      user_id: @user.id
    )
    assert vote.valid?
  end

  test "vote_thumbs_up returns 1 true vote for wiley's bbq" do
    @count = Vote.total_thumbs_up(@restaurant.id)
    assert_equal 1, @count
  end
end

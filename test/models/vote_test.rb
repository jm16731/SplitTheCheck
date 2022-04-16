require "test_helper"

class VoteTest < ActiveSupport::TestCase

  setup do
    @restaurant = Restaurant.create(
      name: "Wiley's",
      location: "Highway 80"
    )
    @user = User.create(
      email: "testing@example.com",
      password: "aaaaaaaaaaa",
      password_confirmation: "aaaaaaaaaaa"
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

  test "can create new vote by new" do
    vote = Vote.new(
      restaurant: restaurants(:joe),
      split: true,
      user: users(:admin)
    )
    assert vote.valid?
    assert vote.errors[:split].empty?
    assert vote.restaurant_id.present?
    assert vote.user_id.present?
  end

  test "vote valid if have attributes & references, done by create" do
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

end

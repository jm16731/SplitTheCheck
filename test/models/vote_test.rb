require "test_helper"

class VoteTest < ActiveSupport::TestCase

  #logic for random query by Mohamad's answer at https://stackoverflow.com/questions/2752231/random-record-in-activerecord
  setup do
    @restaurant = Restaurant.create(name: "Wiley's", location: "Highway 80")
    @user = User.create(email: "testing@example.com", password: "aaaaaaaaaaa", password_confirmation: "aaaaaaaaaaa")
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

  test "vote valid is have attributes & references" do
    vote = Vote.create!(
      split: true,
      restaurant_id: @restaurant.id,
      user_id: @user.id
    )
    assert vote.valid?
  end
end

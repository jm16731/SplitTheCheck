require "test_helper"

class VoteTest < ActiveSupport::TestCase

  setup do
    #@restaurant = restaurants(:one)
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
end

require "test_helper"

class VotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

end

=begin
setup do
  @vote = votes(:vote_for_joe)
  sign_in users(:admin)
end

test "should get index" do
  get votes_url
  assert_response :success
end

test "should get new, if logged in" do
  get new_vote_url
  assert_response :success
end

test "should get new" do
  sign_out :user
  get new_vote_url
  assert_redirected_to :new_user_session
end

test "should create vote, if logged in" do
  assert_difference('Vote.count') do
    post votes_url, params: {
      vote: {
        restaurant: restaurants(:joe),
        split: true,
        user: users(:admin)
      }
    }
  end

  assert_redirected_to vote_url(Vote.last)
  assert_equal "Vote was successfully created.", flash[:notice]
end

test "should not create vote, if not logged in" do
  sign_out :user
  assert_difference('Vote.count', 0) do
    post votes_url, params: {
      vote: {
        restaurant: restaurants(:joe),
        split: true,
        user: users(:admin)
      }
    }
  end

  assert_redirected_to :new_user_session
end

test "should show vote" do
  get vote_url(@vote)
  assert_response :success
end

test "should get edit, if logged in" do
  get edit_vote_url(@vote)
  assert_response :success
end

test "should not get edit, if not logged in" do
  sign_out :user
  get edit_vote_url(@vote)
  assert_redirected_to :new_user_session
end

test "should update vote, if logged in" do
  patch vote_url(@vote), params: {
    vote: {
      restaurant: restaurants(:joe),
      split: false,
      user: users(:admin)
    }
  }
  assert_equal 6, Vote.count
  assert_redirected_to vote_url(@vote)
  assert_equal "Vote was successfully updated.", flash[:notice]
end

test "should not update vote, if not logged in" do
  sign_out :user
  patch vote_url(@vote), params: {
    vote: {
      restaurant: restaurants(:joe),
      split: false,
      user: users(:admin)
    }
  }
  assert_redirected_to :new_user_session
end

test "should destroy vote, if logged in" do
  assert_difference('Vote.count', -1) do
    delete vote_url(@vote)
  end

  assert_redirected_to votes_url
end

test "should not destroy vote, if not logged in" do
  sign_out :user
  assert_difference('Vote.count', 0) do
    delete vote_url(@vote)
  end

  assert_redirected_to :new_user_session
end
=end

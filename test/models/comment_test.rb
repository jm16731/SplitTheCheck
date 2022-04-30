require "test_helper"

class CommentTest < ActiveSupport::TestCase

  setup do
    @comment = comments(:one)
  end

  test "comment attributes & references must not be empty" do
    comment = Comment.new
    assert comment.invalid?
    assert comment.errors[:comment].any?
    assert_nil comment.restaurant_id
    assert_nil comment.user_id
    assert_equal 4, Comment.count
  end

  test "can create new comment by new" do
    comment = Comment.new(
      restaurant: restaurants(:joe),
      comment: "Lorem",
      user: users(:admin)
    )
    assert comment.valid?
    assert comment.errors[:comment].empty?
    assert comment.restaurant_id.present?
    assert comment.user_id.present?

    comment.save
    assert_equal 5, Comment.count
  end

  test "invalid if comment is empty" do
    comment = Comment.new(
      restaurant: restaurants(:joe),
      comment: "",
      user: users(:admin)
    )
    assert comment.invalid?
    assert comment.errors[:comment].any?
    assert comment.restaurant_id.present?
    assert comment.user_id.present?
  end

  test "comment valid if have attributes & references, done by create" do
    comment = Comment.create!(
      comment: "Lorem",
      restaurant: restaurants(:joe),
      user: users(:admin)
    )
    assert comment.valid?

    assert_equal 5, Comment.count

    comment_2 = Comment.create!(
      comment: "Lorem",
      restaurant: restaurants(:joe),
      user: users(:admin)
    )
    assert comment_2.valid?

    assert_equal 6, Comment.count
  end

end

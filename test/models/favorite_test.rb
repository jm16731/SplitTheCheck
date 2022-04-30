require "test_helper"

class FavoriteTest < ActiveSupport::TestCase
  setup do
    @favorite = favorites(:one)
  end

  test "favorites references must not be empty" do
    favorite = Favorite.new
    assert favorite.invalid?
    assert_nil favorite.restaurant_id
    assert_nil favorite.user_id
    assert_equal 2, Favorite.count
  end

  test "can create new favorite by new" do
    favorite = Favorite.new(
      restaurant: restaurants(:joe),
      user: users(:admin)
    )
    assert favorite.valid?
    assert favorite.restaurant_id.present?
    assert favorite.user_id.present?

    favorite.save
    assert_equal 3, Favorite.count
  end

  test "fvaorite valid if have references, done by create" do
    favorite = Favorite.create!(
      restaurant: restaurants(:joe),
      user: users(:admin)
    )
    assert favorite.valid?

    assert_equal 3, Favorite.count

    favorite = Favorite.create!(
      restaurant: restaurants(:wiley),
      user: users(:dork)
    )
    assert favorite.valid?

    assert_equal 4, Favorite.count
  end
end

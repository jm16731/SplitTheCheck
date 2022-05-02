require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
      @admin = users(:admin)
      @no_fav = users(:no_fav)
      @wiley = restaurants(:wiley)
  end

  test "admin should only have wiley as favorite" do
    @restaurants = @admin.favorite_restaurants
    assert_equal 1, @restaurants.length

    @restaurants.each do |restaurant|
      assert_equal @wiley.name, restaurant.name
      assert_equal @wiley.id, restaurant.id
      assert_equal @wiley.location, restaurant.location
    end
  end

  test "user no_fav has no favorite restaurants" do
    @restaurants = @no_fav.favorite_restaurants
    assert_equal 0, @restaurants.length
  end
end

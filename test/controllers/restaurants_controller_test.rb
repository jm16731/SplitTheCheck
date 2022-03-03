require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should be 12 restaurants" do
    assert_equal 12, Restaurant.count
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get first" do
    get first_path
    assert_redirected_to restaurants_url
  end

  test "should get last" do
    get last_path
    assert_redirected_to restaurants_url
  end

  test "should get previous 10" do
    get prev_10_path
    assert_redirected_to restaurants_url
  end

  test "should get next 10" do
    get next_10_path
    assert_redirected_to restaurants_url
  end

  test "going to first should set session to zero" do
    get restaurants_url
    assert_nil session[:offset]
    get first_path
    assert_equal 0, session[:offset]
  end

  test "going to last should set session to near max" do
    get restaurants_url
    assert_nil session[:offset]
    get last_path
    assert_equal 10, session[:offset]
  end

  test "navigating back & forth works, doesn't overflow, can happen many times" do
    get restaurants_url
    assert_nil session[:offset]
    get last_path
    assert_equal 10, session[:offset]
    get first_path
    assert_equal 0, session[:offset]
    get first_path
    assert_equal 0, session[:offset]
    get next_10_path
    assert_equal 10, session[:offset]
    get next_10_path
    assert_equal 10, session[:offset]
    get last_path
    assert_equal 10, session[:offset]
    get last_path
    assert_equal 10, session[:offset]
    get prev_10_path
    assert_equal 0, session[:offset]
    get next_10_path
    assert_equal 10, session[:offset]
    get prev_10_path
    assert_equal 0, session[:offset]
    get prev_10_path
    assert_equal 0, session[:offset]
    get first_path
    assert_equal 0, session[:offset]
    get prev_10_path
    assert_equal 0, session[:offset]
    get next_10_path
    assert_equal 10, session[:offset]
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: {
        restaurant: {
          location: @restaurant.location,
          name: @restaurant.name,
          will_split: @restaurant.will_split,
          wont_split: @restaurant.wont_split
        }
      }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: {
      restaurant: {
        location: @restaurant.location,
        name: @restaurant.name,
        will_split: @restaurant.will_split,
        wont_split: @restaurant.wont_split
      }
    }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy restaurant" do
    assert_difference('Restaurant.count', -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_url
  end
end

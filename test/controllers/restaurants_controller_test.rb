require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test "should be 12 restaurants" do
    assert_equal 12, Restaurant.count
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
    assert_select "h1", "Restaurants"
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
    assert_select "h1", "Split the Check"
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

  test "should get thumbs_up" do
    patch thumbs_up_path params: {
      id: 1
    }
    assert_redirected_to restaurants_url
  end

  test "should get thumbs_down" do
    patch thumbs_down_path params: {
      id: 1
    }
    assert_redirected_to restaurants_url
  end

  test "should get search" do
    get search_path
    assert_template :index
    assert_select "h1", "Restaurants"
  end

  test "should get clear" do
    get clear_path
    assert_redirected_to restaurants_url
  end

  test "should find zero restaurant with BBQ, Johnny Mercer Blvd" do
    get search_path, params: {
      search_by_name: "BBQ",
      search_by_location: "Johnny Mercer Blvd"
    }

    assert_template :index

    assert 0, Restaurant.all.
    	order(:name).where("name like 'BBQ'").
    	where("location like 'Johnny Mercer Blvd'").count

    assert_select "table tbody tr", count: 0
  end

  test "should find one restaurant with BBQ, Highway 80" do
    get search_path, params: {
      search_by_name: "Wiley",
      search_by_location: "384 Highway 80"
    }

    assert_template :index

    assert 1, Restaurant.all.
      order(:name).where("name like 'Wiley'").
      where("location like '384 Highway 80'").count

    assert_select "table tbody tr", count: 1
  end

  test "should find three restaurants with location starting with 98" do
    get search_path, params: {
      search_by_name: nil,
      search_by_location: "98"
    }

    assert_template :index

    assert 3, Restaurant.all.
      order(:name).where("location like '98'").count

    assert_select "table tbody tr", count: 3
  end

  test "should find two restaurants with S" do
    get search_path, params: {
      search_by_name: "S",
      search_by_location: nil
    }

    assert_template :index

    assert 2, Restaurant.all.
      order(:name).where("name like 'S'").count

    assert_select "table tbody tr", count: 2
  end

  test "multiple searches work" do
    get search_path, params: {
      search_by_name: "BBQ",
      search_by_location: "Johnny Mercer Blvd"
    }

    assert_template :index

    get search_path, params: {
      search_by_name: "BBQ",
      search_by_location: "Highway 80"
    }

    assert_template :index
  end
end

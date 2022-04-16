require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @restaurant = restaurants(:joe)
    sign_in users(:admin)
    @thumbs_up_src = "/assets/thumbs_up-31deedd24365bb78a6a111e446096cedfc3d73bac7dce11130ec044cdf6c6880.png"
    @thumbs_down_src = "/assets/thumbs_down-513a3b5d910cefc9dcc20a90ca33b4bc572f4b6041ee234ecfe41282a1416730.jpg"
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
  end

  test "index, logged in, has header, table, 7 columns" do
    get restaurants_url
    assert_select "h1", "Restaurants"
    assert_select "table thead tr th", count: 5
    assert_select "table tbody tr", count: 10
    assert_select "a", "Show", count: 10
    assert_select "table tbody tr td", count: 7 * 10
  end

  test "index, logged out, has header, table, 5 columns" do
    sign_out :user
    get restaurants_url
    assert_select "h1", "Restaurants"
    assert_select "table thead tr th", count: 5
    assert_select "table tbody tr", count: 10
    assert_select "a", "Show", count: 10
    assert_select "table tbody tr td", count: 5 * 10
  end

  test "index has search form" do
    get restaurants_url
    assert_select "input[type=submit]", 1
    assert_select "a", "Clear"
  end

  test "index, logged in, has navigation links, with new restaurant" do
    get restaurants_url
    assert_select "a", "fake_email@not_a_real_url.com"
    assert_select "a", { :href => :new_user_session }, false
    assert_select "a", { :href => :new_user_registration }, false
    assert_select "a", "Log Out"
    assert_select "a", "New Restaurant"
    assert_select "a", "First"
    assert_select "a", "Previous 10"
    assert_select "a", "Next 10"
    assert_select "a", "Last"
  end

  test "index, logged out, has navigation links, no new restaurant" do
    sign_out :user
    get restaurants_url
    assert_select "a", "Log In"
    assert_select "a", "Register"
    assert_select "a", { :href => :new_restaurant }, false
    assert_select "a", { :href => :edit_user_registration }, false
    assert_select "a", { :href => :destroy_user_session }, false
    assert_select "a", "First"
    assert_select "a", "Previous 10"
    assert_select "a", "Next 10"
    assert_select "a", "Last"
  end

  test "first_path should redirect to index" do
    get first_path
    assert_redirected_to restaurants_url
  end

  test "last_path should redirect to index" do
    get last_path
    assert_redirected_to restaurants_url
  end

  test "previous_10_path should redirect to index" do
    get prev_10_path
    assert_redirected_to restaurants_url
  end

  test "next_10_path should redirect to index" do
    get next_10_path
    assert_redirected_to restaurants_url
  end

  test "going to first should set session to zero" do
    get restaurants_url
    assert_nil session[:offset]
    get first_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10
  end

  test "going to last should set session to near max" do
    get restaurants_url
    assert_nil session[:offset]
    get last_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2
  end

  test "navigating back & forth works, doesn't overflow, can happen many times" do
    get restaurants_url
    assert_nil session[:offset]

    get last_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2

    get first_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10

    get first_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10

    get next_10_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2

    get next_10_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2

    get last_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2

    get last_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2

    get prev_10_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10

    get next_10_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2

    get prev_10_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10

    get prev_10_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10

    get first_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10

    get prev_10_path
    follow_redirect!
    assert_equal 0, session[:offset]
    assert_select "table tbody tr", count: 10

    get next_10_path
    follow_redirect!
    assert_equal 10, session[:offset]
    assert_select "table tbody tr", count: 2
  end

  test "should get new, if logged in" do
    get new_restaurant_url
    assert_response :success
  end

  test "should not get new, if logged out" do
    sign_out :user
    get new_restaurant_url
    assert_redirected_to :new_user_session
  end

  test "should create restaurant, if logged in" do
    assert_difference('Restaurant.count', 1) do
      post restaurants_url, params: {
        restaurant: {
          location: @restaurant.location,
          name: @restaurant.name,
        }
      }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should not create restaurant, if logged out" do
    sign_out :user
    assert_difference('Restaurant.count', 0) do
      post restaurants_url, params: {
        restaurant: {
          location: @restaurant.location,
          name: @restaurant.name,
        }
      }
    end

    assert_redirected_to :new_user_session
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "show page, logged in, should have header, back link, thumbs up/down" do
    get restaurant_url(@restaurant)
    assert_select "h1", "Split the Check"
    assert_select "a", "Back"
    assert_select "img", count: 2
    assert_select "img" do
    	assert_select "[src=?]", @thumbs_up_src
    	assert_select "[src=?]", @thumbs_down_src
    end
  end

  test "show page, logged out should have header, back link, no thumbs up/down" do
    sign_out :user
    get restaurant_url(@restaurant)
    assert_select "h1", "Split the Check"
    assert_select "a", "Back"
    assert_select "img", count: 0
  end

  test "should get edit when logged in" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should not get edit when logged out" do
    sign_out :user
    get edit_restaurant_url(@restaurant)
    assert_redirected_to :new_user_session
  end

  test "should update restaurant, if logged in" do
    assert @restaurant.name = "Joe's"
    assert @restaurant.location = "Highway 156"

    patch restaurant_url(@restaurant), params: {
      restaurant: {
        location: "112 Highway 80",
        name: "Greg's Random Slop"
      }
    }
    assert_redirected_to restaurant_url(@restaurant)

    assert @restaurant.name = "Greg's Random Slop"
    assert @restaurant.location = "112 Highway 80"
  end

  test "should not update restaurant, if logged out" do
    sign_out :user

    patch restaurant_url(@restaurant), params: {
      restaurant: {
        location: "112 Highway 80",
        name: "Greg's Random Slop"
      }
    }
    assert_redirected_to :new_user_session
  end

  test "should destroy restaurant, if logged in" do
    assert_difference('Restaurant.count', -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_url
  end

  test "should not destroy restaurant, if logged out" do
    sign_out :user
    assert_difference('Restaurant.count', 0) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to :new_user_session
  end

  test "thumbs_up should redirect and increase" do
    patch thumbs_up_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 2, @restaurant.reload.total_thumbs_up
    assert_equal "Thank you for informing us of who splits the check", flash[:notice]
  end

  test "thumbs_down should redirect and decrease" do
    patch thumbs_down_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 1, @restaurant.reload.total_thumbs_down
    assert_equal "Thank you for informing us of those who refuse to split the check", flash[:notice]
  end

  test "repeated thumbs_up / thumbs_down works as expected" do
    patch thumbs_up_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 2, @restaurant.reload.total_thumbs_up

    patch thumbs_down_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 1, @restaurant.reload.total_thumbs_down

    patch thumbs_up_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 3, @restaurant.reload.total_thumbs_up

    patch thumbs_up_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 4, @restaurant.reload.total_thumbs_up

    patch thumbs_up_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 5, @restaurant.reload.total_thumbs_up

    patch thumbs_down_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 2, @restaurant.reload.total_thumbs_down

    patch thumbs_down_path(:id => @restaurant.id)
    assert_redirected_to restaurants_url
    assert_equal 3, @restaurant.reload.total_thumbs_down
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

  test "multiple searches work, including with navigation" do
    get search_path, params: {
      search_by_name: "Wiley",
      search_by_location: "384 Highway 80"
    }

    assert_template :index
    assert 1, Restaurant.all.
      order(:name).where("name like 'Wiley'").
      where("location like '384 Highway 80'").count
    assert_select "table tbody tr", count: 1

    get last_path
    get first_path
    get first_path
    get next_10_path
    get next_10_path
    get last_path

    get search_path, params: {
      search_by_name: "S",
      search_by_location: nil
    }

    assert_template :index
    assert 2, Restaurant.all.
      order(:name).where("name like 'S'").count
    assert_select "table tbody tr", count: 2
  end
end

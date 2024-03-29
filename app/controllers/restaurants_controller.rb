class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy thumbs_up thumbs_down favorite unfavorite new_comment ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy thumbs_up thumbs_down favorite unfavorite new_comment ]

  # GET /restaurants or /restaurants.json
  # Logic for search is thanks to https://medium.com/@rrrachelrath/beginners-guide-to-making-a-ruby-on-rails-search-bar-9e94a9b161d9
  def index
    @restaurants = Restaurant.all.
      order(:name).limit(10).offset(session[:offset])
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def first
    session[:offset] = 0
    redirect_to restaurants_url
  end

  def prev_10
    @session = (session[:offset].to_s.to_i - 10)
    if @session <= 10
      @session = 0
    end
    session[:offset] = (@session)
    redirect_to restaurants_url
  end

  def next_10
    @session = (session[:offset].to_s.to_i + 10)
    if @session >= (Restaurant.count).floor(-1)
      @session = (Restaurant.count).floor(-1)
    end
    session[:offset] = @session
    redirect_to restaurants_url
  end

  def last
    session[:offset] = (Restaurant.count).floor(-1)
    redirect_to restaurants_url
  end

=begin
  def search
    session[:offset] = 0

    if params[:search_by_name] && params[:search_by_name] != ""
      session[:search_by_name] = params[:search_by_name]
    else
      session[:search_by_name] = nil
    end

    if params[:search_by_location] && params[:search_by_location] != ""
      session[:search_by_location] = params[:search_by_location]
    else
      session[:search_by_location] = nil
    end

    redirect_to restaurants_url
  end
=end

  def search
    @restaurants = Restaurant.all.order(:name)

    if params[:search_by_name].present?
      @restaurants = @restaurants.search_by_name(params[:search_by_name])
    end

    if params[:search_by_location].present?
      @restaurants = @restaurants.search_by_location(params[:search_by_location])
    end

    render "index"
  end

  def clear
    redirect_to restaurants_url
  end

  def thumbs_up
    @restaurant.thumbs_up(current_user)
    redirect_to restaurants_url, notice: "Thank you for informing us of who splits the check"
  end

  def thumbs_down
    @restaurant.thumbs_down(current_user)
    redirect_to restaurants_url, notice: "Thank you for informing us of those who refuse to split the check"
  end

  def favorite
    @restaurant.favorite.create!(user: current_user)
    redirect_to restaurants_url, notice: "Restaurant favorited!"
  end

  def unfavorite
    favorite = Favorite.where(user: current_user, restaurant: @restaurant)
    Favorite.delete(favorite)
    redirect_to restaurants_url, notice: "Restaurant unfavorited!"
  end

  def new_comment
    @comment = Comment.new(
      restaurant: @restaurant,
      user: current_user,
      comment: params[:new_comment]
    )

    if @comment.save
      redirect_to restaurants_url, notice: "Comment submitted. Thank you!"
    else
      redirect_to restaurants_url, notice: "Comment not submitted. Try again."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :location)
    end
end

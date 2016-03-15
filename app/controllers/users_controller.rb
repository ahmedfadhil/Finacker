class UsersController < ApplicationController
  def my_portfolio
    @user_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @friendships = current_user.friends
  end

  def search
    @users = User.search(params[:search_param])
    if @users
      @users = current_user.except_current_user(@users)
      render partial: 'friends/lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      redirect_to my_friends_path, notice: "Friend was successfully added."
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend."
    end
  end
  # before_action :set_welcome, only: [:show, :edit, :update, :destroy]
  #
  # # GET /welcomes
  # # GET /welcomes.json
  # def index
  #   @welcomes = Welcome.all
  # end
  #
  # # GET /welcomes/1
  # # GET /welcomes/1.json
  # def show
  #
  # end
  #
  # # GET /welcomes/new
  # def new
  #   @welcome = Welcome.new
  # end
  #
  # # GET /welcomes/1/edit
  # def edit
  # end
  #
  # # POST /welcomes
  # # POST /welcomes.json
  # def create
  #   @welcome = Welcome.new(welcome_params)
  #
  #   respond_to do |format|
  #     if @welcome.save
  #       format.html { redirect_to @welcome, notice: 'Welcome was successfully created.' }
  #       format.json { render :show, status: :created, location: @welcome }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @welcome.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /welcomes/1
  # # PATCH/PUT /welcomes/1.json
  # def update
  #   respond_to do |format|
  #     if @welcome.update(welcome_params)
  #       format.html { redirect_to @welcome, notice: 'Welcome was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @welcome }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @welcome.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /welcomes/1
  # # DELETE /welcomes/1.json
  # def destroy
  #   @welcome.destroy
  #   respond_to do |format|
  #     format.html { redirect_to welcomes_url, notice: 'Welcome was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_welcome
  #     @welcome = Welcome.find(params[:id])
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def welcome_params
  #     params.fetch(:welcome, {})
  #   end
end

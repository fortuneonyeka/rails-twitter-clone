class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner?, only: %i[edit destroy]

  # GET /tweets
  def index
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new
  end

  # GET /tweets/1 
  def show
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path(@tweet), notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end


   # GET /tweets/1/edit
  #  def edit
  #   @tweet = Tweet.find(params[:id])
  #   unless current_user == @tweet.user
  #     redirect_back fallback_location: root_path, notice: 'You cannot edit tweet belonging to another user'
  #   end
  # end

  # PATCH/PUT /tweets/1 
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to tweet_url(@tweet), notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def owner?
      unless current_user == @tweet.user
        redirect_back fallback_location: root_path, notice: 'You can only edit or delete your tweets'
      end
    end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:tweet)
    end
end

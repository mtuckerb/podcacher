class PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy, :update_podcast]

  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.all
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
    respond_to do |format|
      format.html do
        @episodes = @podcast.episodes
      end
      format.rss do
        @episodes = @podcast.episodes
        render :layout => false
      end
    end
  end

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    PodcastJob.perform_later(url: params[:podcast][:url], cache_dir: params[:podcast][:cache_dir])
    respond_to do |format|
        format.html { redirect_to podcasts_path, notice: 'Podcast was successfully created... probably' }
    end
  end

  # PATCH/PUT /podcasts/1
  # PATCH/PUT /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { render :show, status: :ok, location: @podcast }
      else
        format.html { render :edit }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url, notice: 'Podcast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_podcast
    UpdatePodcastJob.perform_later(podcast: @podcast)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.joins(:episodes).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def podcast_params
      params.require(:podcast).permit(:name, :url)
    end
end

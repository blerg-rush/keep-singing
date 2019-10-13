class VideosController < ApplicationController
  def index
    query = params[:q].presence
    @videos = if query
                Video.search(query)
              else
                flash.now[:info] = 'No videos found'
                Video.order('created_at DESC').take(50)
              end
    @video = @videos.first
  end

  def search
    query = params[:q].presence
    @videos = if query
                Video.search(query)
              else
                flash.now[:info] = 'No videos found'
                Video.order('created_at DESC').take(50)
              end
    @video = @videos.first
  end

  def show
    @videos = Video.order('created_at DESC')
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
    @channel = Channel.new
  end

  def create
    @video = Video.new(video_params)
    if @video.scrape_and_save!
      flash[:success] = 'Video added!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Video ID error'
      render :new
    end
  end

  private

    def video_params
      params.require(:video).permit(:uid)
    end
end

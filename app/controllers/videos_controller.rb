class VideosController < ApplicationController
  def index
    @videos = Video.order('created_at DESC').take(50)
    @video = Video.last
  end

  def search
    query = params[:q].presence
    @videos = if search
                Video.search(query)
              else
                Video.order('created_at DESC').take(50)
              end
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
      params.require(:video).permit(:uid, :q)
    end
end

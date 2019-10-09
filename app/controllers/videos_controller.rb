class VideosController < ApplicationController
  def index
    @videos = Video.order('created_at DESC')
    @video = Video.last
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
    if @video.save
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

class ChannelsController < ApplicationController
  def index
    @channels = Channel.all
  end

  def create
    @channel = Channel.find_or_create_by(channel_params)
    if @channel.save
      flash[:success] = 'Channel imported!'
      redirect_to root_path
    else
      flash.now[:danger] = 'Channel ID error'
      render 'videos/new'
    end
  end

  def destroy; end

  private

    def channel_params
      params.require(:channel).permit(:uid)
    end
end

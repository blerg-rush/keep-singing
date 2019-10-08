class ChannelsController < ApplicationController
  def index
    @channels = Channel.all
  end

  def create; end

  def destroy; end

  private

    def channel_params
      params.require(:channel).permit(:uid)
    end
end

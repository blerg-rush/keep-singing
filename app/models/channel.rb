class Channel < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :videos, dependent: :nullify

  # before_validation(if: -> { uid.present? && changes[:uid].present? }) do
  #   update_videos
  # end

  # Fills all channel video details from API
  def update_videos
    channel = Yt::Channel.new id: uid
    channel.videos.each do |yt_video|
      video = videos.find { |v| v.uid == yt_video.id }
      video ||= videos.build(uid: yt_video.id)
      video.fill_details(yt_video)
    end

    save
  end

  private

    def start_scrape
      channel = Yt::Channel.new id: uid
      videos = channel.videos.first(50)
      videos.each do |yt_video|
        video = videos.find { |v| v.uid == yt_video.id }
        video ||= videos.build(uid: yt_video.id)
        video.fill_details(yt_video)
      end
      save
      self.page_token = channel.instance_variable_get(:@page_token)
    end

    def resume_scrape
      channel = Yt::Channel.new id: uid
      channel.instance_variable_set(:@page_token, page_token)
      videos.each do |yt_video|
        video = videos.find { |v| v.uid == yt_video.id }
        video ||= videos.build(uid: yt_video.id)
        video.fill_details(yt_video)
      end
      save
      self.page_token = channel.instance_variable_get(:@page_token)
    end
end

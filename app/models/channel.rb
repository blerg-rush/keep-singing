class Channel < ApplicationRecord
  has_many :videos
  validates :uid, presence: true

  private

    def add_videos
      channel = YT::Channel.new id: uid
      channel.videos.each do |yt_video|
        video = videos.find_or_initialize_by(uid: yt_video.id)
        video.title = yt_video.title
        video.link = "https://www.youtube.com/watch?v=#{yt_video.id}"
        video.description = yt_video.description
        video.channel_uid = uid
        video.save
      end
    end
end

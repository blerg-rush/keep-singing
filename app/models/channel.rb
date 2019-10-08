class Channel < ApplicationRecord
  has_many :videos, dependent: :nullify
  validates :uid, presence: true

  def update_videos
    channel = Yt::Channel.new id: uid
    channel.videos.each do |yt_video|
      video = videos.find_or_initialize_by(uid: yt_video.id)
      video.title = yt_video.title
      video.link = "https://www.youtube.com/watch?v=#{yt_video.id}"
      video.description = yt_video.description
      video.channel_uid = uid
      video.channel_id = id
      video.save(validate: false)
    end
  end
end

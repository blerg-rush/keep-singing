class Channel < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  has_many :videos, dependent: :nullify

  before_validation(if: -> { uid.present? && changes[:uid].present? }) do
    update_videos
  end

  # Fills all channel video details from API
  def update_videos
    channel = Yt::Channel.new id: uid
    channel.videos.each do |yt_video|
      next unless Video.find_by(uid: yt_video.id).nil?

      video = videos.build(uid: yt_video.id)
      video.fill_details(yt_video)
      video.save(validate: false)
    end
  end
end

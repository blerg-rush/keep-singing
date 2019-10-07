class AddChannelIdToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :channel_id, :string
  end
end

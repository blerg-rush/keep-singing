class AddChannelRelationToVideos < ActiveRecord::Migration[6.0]
  def change
    add_reference :videos, :channel
  end
end

class ChangeChannelIdName < ActiveRecord::Migration[6.0]
  def change
    rename_column :videos, :channel_id, :channel_uid
  end
end

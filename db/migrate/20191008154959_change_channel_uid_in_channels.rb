class ChangeChannelUidInChannels < ActiveRecord::Migration[6.0]
  def change
    rename_column :channels, :channel_uid, :uid
  end
end

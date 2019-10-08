class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :title
      t.string :channel_uid

      t.timestamps
    end
  end
end

class AddLastScrapedToChannels < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :last_scraped, :datetime
  end
end

class AddDescriptionToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :description, :string
  end
end

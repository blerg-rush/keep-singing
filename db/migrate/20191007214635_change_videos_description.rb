class ChangeVideosDescription < ActiveRecord::Migration[6.0]
  def change
    change_column :videos, :description, :text
  end
end

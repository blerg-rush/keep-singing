class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :link
      t.string :title
      t.string :uid

      t.timestamps
    end
    add_index :videos, :uid
  end
end

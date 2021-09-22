class AddSpotifyIdIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :spotify_id
  end
end

class AddPodcastIdToEpisodes < ActiveRecord::Migration[5.2]
  def up
    add_column :episodes, :podcast_id, :integer
    add_foreign_key :episodes, :podcasts
  end

  def down
    remove_column :episodes, :podcast_id
    remove_foreign_key :episodes, :podcasts
  end
end

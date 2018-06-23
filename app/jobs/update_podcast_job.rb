class UpdatePodcastJob < ApplicationJob

  queue_as :default

  def perform(podcast:)
    podcast.download_new_episodes
  end
end

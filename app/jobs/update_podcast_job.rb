class UpdatePodcastJob < ApplicationJob

  queue_as :default

  def perform(podcast:)
    logger.info "checking #{podcast} for new episodes"
    podcast.download_new_episodes
  end
end

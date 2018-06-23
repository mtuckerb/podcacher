class PodcastJob < ApplicationJob

  queue_as :default

  def perform(url:, cache_dir: nil)
    @podcast = Podcast.new_from_feed(url: url)
    if cache_dir.present?
      @podcast.episodes_media_from_local_cache(basedir: cache_dir)
    end
  end
end

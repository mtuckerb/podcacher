class PodcastJob < ApplicationJob

  queue_as :default

  def perform(url:, cache_dir: nil)
    @podcast = Podcast.new_from_feed(url: url)
    unless cache_dir.present == nil
      @podcast.episodes_media_from_local_cache(basedir: cache_dir)
    end
  end
end

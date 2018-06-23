require 'rss'
require 'httparty'

class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_one_attached :logo, dependent: :destroy


  def self.new_from_feed(args)
      response = HTTParty.get Feedbag.find(args[:url])[0]
      feed = RSS::Parser.parse response.body, false
      podcast = create(name: feed.channel&.title,
             url: args[:url],
             created_at: feed.channel&.pubDate,
             updated_at: feed.channel&.lastBuildDate,
             author: feed.channel&.itunes_author,
             description: feed.channel&.description&.strip,
             keywords: feed.channel&.itunes_keywords,
             ext: nil,
             explicit: feed.channel&.itunes_explicit,
             email: feed.channel&.itunes_owner&.itunes_email)
      podcast.download_logo(url: feed.channel&.image&.url)
      podcast.save
      podcast.episodes_from_feed
      podcast
  end

  def update_from_feed
      response = HTTParty.get url
      feed = RSS::Parser.parse response.body, false
      podcast = update(name: feed.channel&.title,
             url: feed.channel&.link&.strip,
             created_at: feed.channel&.pubDate,
             updated_at: feed.channel&.lastBuildDate,
             author: feed.channel&.itunes_author,
             description: feed.channel&.description&.strip,
             keywords: feed.channel&.itunes_keywords,
             ext: nil,
             explicit: feed.channel&.itunes_explicit,
             email: feed.channel&.itunes_owner&.itunes_email)
      download_logo(url: feed.channel&.image&.url)
  end

  def download_logo(url:)
    download = open(url)
    self.logo.attach(io: download, filename: filename_from_url(url: url))
  end

  def filename_from_url(url:)
    url.match(/([^\/\\&\?]+\.\w{3,4})(?=([\?&].*$|$))/)[1]
  end

  def episodes_from_feed
    response = HTTParty.get url
    feed = RSS::Parser.parse response.body, false
    feed.items.each do |item|
      next if episodes.where(guid: item.guid.content).exists?
      Episode.create(title: item.title,
                      url: item.enclosure&.url&.strip,
                      guid: item.guid.content,
                      published_on: item.pubDate,
                      description: item.description,
                      podcast_id: self.id)
    end
  end

  def episodes_media_from_local_cache(basedir:)
    episodes.select {|e| e.media.attachment == nil}.each do |episode|
      episode.download_media_from_local_cache(basedir: basedir)
    end
  end

  def download_new_episodes
    episodes_from_feed
    episodes.each do |episode|
      next if episode.media.attached?
      episode.download_media
    end
  end
end

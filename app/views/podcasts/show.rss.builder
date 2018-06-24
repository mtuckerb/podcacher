#encoding: UTF-8
title = @podcast.name
author = @podcast.author
description = @podcast.description
keywords =  @podcast.keywords
ext = @podcast.ext


xml.instruct! :xml, :version => "1.0"

xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.tag!("atom:link",  request.url, "rel"=>"self", "type"=>"application/rss+xml")
    xml.title title
    xml.link request.url
    xml.description description
    xml.language 'en'
    xml.pubDate @episodes.first.created_at.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.created_at.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, @podcast.explicit
    xml.itunes :image, :href =>  (image_tag @podcast.logo if @podcast.logo.attached?)
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, @podcast.email
    end
    xml.itunes :block, 'no'
    # xml.itunes :category, :text => 'Technology' do
    #   xml.itunes :category, :text => 'Software How-To'
    # end
    # xml.itunes :category, :text => 'Education' do
    #   xml.itunes :category, :text => 'Training'
    # end

    @episodes.each do  |episode|
        next unless episode.media.attached?
      xml.item do
        xml.title episode.title
        xml.description episode.description
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.enclosure :url => url_for(episode.media), :length => episode.media.blob.byte_size, :type => episode.media.blob.content_type
        xml.link episode_url(episode)
        xml.guid({:isPermaLink => "false"}, episode.guid)
        xml.itunes :author, author
        xml.itunes :subtitle, truncate(episode.description, :length => 150)
        xml.itunes :summary, episode.description
        xml.itunes :explicit, 'no'
        # xml.itunes :duration, episode.duration
      end
    end
  end
end

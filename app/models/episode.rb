require 'open-uri'

class Episode < ApplicationRecord
  belongs_to :podcast
  has_one_attached :media

  def download_media
    download = open(url)
    self.media.attach(io: download, filename: filename_from_url)
  end

  def download_media_from_local_cache(basedir:)
    self.media.attach(io: File.open(File.join(basedir, self.filename_from_url)), filename: filename_from_url)
  rescue
    puts "Media not found #{File.join(basedir, self.filename_from_url)}"
  end


  def filename_from_url
    filename = url.match(/([^\/\\&\?]+\.\w{3,4})(?=([\?&].*$|$))/)
    if filename
      filename[1]
    else
     guid
   end
  end

end

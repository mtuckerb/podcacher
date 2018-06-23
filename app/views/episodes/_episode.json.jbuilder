json.extract! episode, :id, :title, :url, :guid, :published_on, :description, :created_at, :updated_at
json.url episode_url(episode, format: :json)

json.extract! user, :id, :username, :spotify_id, :created_at, :updated_at
json.url user_url(user, format: :json)

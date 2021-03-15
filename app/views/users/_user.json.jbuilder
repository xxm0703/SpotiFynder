json.extract! user, :id, :username, :password_hash, :password_salt, :spotify_id, :created_at, :updated_at
json.url user_url(user, format: :json)

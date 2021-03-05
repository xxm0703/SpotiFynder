json.extract! session, :id, :new, :created_at, :updated_at
json.url session_url(session, format: :json)

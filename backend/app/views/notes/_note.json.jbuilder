json.extract! note, :id, :ticket_id, :body, :created_at, :updated_at
json.url note_url(note, format: :json)

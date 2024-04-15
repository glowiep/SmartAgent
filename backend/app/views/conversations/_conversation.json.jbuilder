json.extract! conversation, :id, :request_id, :body, :from_customer, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)

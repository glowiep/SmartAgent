json.extract! direct_chat, :id, :sender_id, :receiver_id, :message, :created_at, :updated_at
json.url direct_chat_url(direct_chat, format: :json)

require 'rails_helper'

RSpec.describe ForwardsMailbox, type: :mailbox do
  let(:mail) { Mail.new(from: 'customer@example.com', subject: 'Hello', body: 'Hello world') }

  it 'creates a new request when no request with the same title and from_email exists' do
    mailbox = described_class.new(mail)

    expect do
      mailbox.receive(mail)
    end.to change { Request.count }.by(1)
  end

  it 'creates a new conversation when a request with the same title and from_email exists' do
    Request.create!(title: 'Hello', from_email: 'customer@example.com', customer_name: 'Customer', status_id: 1,
                    agent_id: 1)
    mailbox = described_class.new(mail)

    expect do
      mailbox.receive(mail)
    end.to change { Conversation.count }.by(1)
  end
end

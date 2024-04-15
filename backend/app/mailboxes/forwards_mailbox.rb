class ForwardsMailbox < ApplicationMailbox
  def process
    ticket_id = mail.subject[/\[#(\d+)\]/, 1] # Extract ticket id from subject
    ticket = Ticket.find_by(id: ticket_id) if ticket_id

    ticket ||= Ticket.create!(
      title: mail.subject,
      from_email: mail.from.first,
      customer_name: mail.from.first,
      status_id: 1,
      agent_id: 1
    )
    ActionCable.server.broadcast('tickets', ticket)
    conversation = ticket.conversations.create!(
      body: clean_body(mail),
      from_customer: true,
      ticket_id:
    )
    ActionCable.server.broadcast('conversations', conversation)
    mail.attachments.each do |attachment|
      filename = attachment.decoded
      file = StringIO.new(filename)
      conversation.attachments.attach(io: file, filename: attachment.filename)
    end
  end

  private

  def clean_body(mail)
    body = (mail.html_part&.decoded || mail.body.decoded).split("\r\n\r\n", 2).first
    body.gsub(/(On\s.*wrote:\n>.*\n)+/m, '')
    body.gsub(/(El\s.*escribió:\n>.*\n)+/m, '')
    body.gsub(/<div class="gmail_quote">.*/m, '')
  end
end

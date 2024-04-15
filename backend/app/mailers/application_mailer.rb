class ApplicationMailer < ActionMailer::Base
  default from: 'smartagents3@gmail.com'
  layout 'mailer'

  def ticket_response(ticket, response, attachments = [])
    @ticket = ticket
    @response = ActionController::Base.helpers.sanitize(response).html_safe
    @attachments = Array(attachments)

    # Create a new conversation for the ticket with the body of the response
    conversation = @ticket.conversations.create!(
      body: @response,
      from_customer: false
    )
    @attachments.each do |attachment|
      filename = attachment.original_filename
      file_content = File.read(attachment.tempfile)
      conversation.attachments.attach(io: StringIO.new(file_content), filename:filename)
      mail.attachments[filename] = file_content
    end

    puts @response
    ActionCable.server.broadcast('tickets', conversation.as_json(methods: :attachments_urls))


    mail(to: @ticket.from_email, subject: "Re: [##{@ticket.id}] Ticket response")
  end
end

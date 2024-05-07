# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Agent.destroy_all
Role.destroy_all
Status.destroy_all
Ticket.destroy_all
Conversation.destroy_all

# Seed data for roles
admin_role = Role.create(role: 'Admin', description: 'Administrator role')

# Seed data for agents table
Agent.create(email: 'triage@gmail.com', full_name: 'Triage', password: 'password', role_id: admin_role.id)
Agent.create(email: 'sebastianvaron96@gmail.com', full_name: 'Sebastian varon', password: 'password',
             role_id: admin_role.id)
Agent.create(email: 'glim@gmail.com', full_name: 'Gloria Lim', password: 'password',
             role_id: admin_role.id)

             7.times do
              Agent.create(
                email: Faker::Internet.unique.email,
                full_name: Faker::Name.name,
                password: 'password',
                role_id: admin_role.id
              )
            end
# Seed data for statuses
Status.create(description: 'Open')
Status.create(description: 'Answered')
Status.create(description: 'Resolved')
# Create some tickets

ticket1 = Ticket.create!(
  title: "Website Traffic Help",
  from_email: Faker::Internet.email,
  customer_name: Faker::Name.name,
  agent_id: 3,
  status_id: 2
)

# Create conversations for the ticket
conversation1 = ticket1.conversations.create!(
  body: "<p>Hi SmartAgent,</p><p><br></p><p>I am touching base to let you know that I am experiencing a significant drop in website traffic.</p><p><br></p><p>Thanks.</p>",
  from_customer: true
)
conversation1.attachments.attach(io: File.open(Rails.root.join('public', 'placeholder.jpg')), filename: 'placeholder.jpg')

conversation2 = ticket1.conversations.create!(
  body: "<p>Hello,</p><p><br></p><p>Let me check the issue and get back to you.</p><p><br></p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>",
  from_customer: false
)
conversation2.attachments.attach(io: File.open(Rails.root.join('public', 'placeholder.jpg')), filename: 'placeholder.jpg')

conversation3 = ticket1.conversations.create!(
  body: "<p>Hello,</p><p><br></p><p>I have identified the issue and it has been resolved. Your website traffic should be back to normal now.</p><p><br></p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>",
  from_customer: false
)
conversation4 = ticket1.conversations.create!(
  body: "Thank you for your help. I appreciate it.",
  from_customer: true
)
# Create another ticket
ticket2 = Ticket.create!(
  title: "Social Media Visibility Help",
  from_email:  Faker::Internet.email,
  customer_name: Faker::Name.name,
  agent_id: 1,
  status_id: 2
)

# Create conversations for the ticket
conversation5 = ticket2.conversations.create!(
  body: "<p>Hi,</p><p><br></p><p>I am reaching out to get some help with increasing my social media visibility. Can you help me with that?</p><p><br></p><p>Thanks.</p>",
  from_customer: true
)
conversation5.attachments.attach(io: File.open(Rails.root.join('public', 'placeholder.jpg')), filename: 'placeholder.jpg')


conversation6 = ticket2.conversations.create!(
  body: "Sure, I can help you with that. Let me take a look at your social media accounts and get back to you.",
  from_customer: false
)
conversation6.attachments.attach(io: File.open(Rails.root.join('public', 'placeholder.jpg')), filename: 'placeholder.jpg')


conversation7 = ticket2.conversations.create!(
  body: "Thanks I will be waiting for your response.",
  from_customer: true
)
conversation8 = ticket2.conversations.create!(
  body: "I have reviewed your social media accounts and have some recommendations for you. The team will implement them shortly.",
  from_customer: false
)

conversation9 = ticket2.conversations.create!(
  body: "thank you for your help",
  from_customer: true
)


ticket3 = Ticket.create!(
  title: "Facebook Ads Help",
  from_email:  Faker::Internet.email,
  customer_name: Faker::Name.name,
  agent_id: 2,
  status_id: 2
)

conversation10 = ticket3.conversations.create!(
  body: "I am reaching out to get some help with setting up Facebook ads. Can you help me with that?",
  from_customer: true
)

conversatio11 = ticket3.conversations.create!(
  body: "<p>Hello,</p><p><br></p><p>Sure, I can help you with that. Let me take a look at your social media accounts and get back to you. </p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>",
  from_customer: false
)
conversation12 = ticket3.conversations.create!(
  body: "Thanks I will be waiting for your response.",
  from_customer: true
)
conversation13 = ticket3.conversations.create!(
  body: "<p>Hello,</p><p><br></p><p>I have reviewed your social media accounts and the problem may be with your budget. I will make some changes and get back to you.</p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>",
  from_customer: false
)

conversation14 = ticket3.conversations.create!( body: "Thank you for your help.", from_customer: true)

conversation15 = ticket3.conversations.create!( body: "<p>Hello,</p><p><br></p><p>I have made the changes and your ads should be running smoothly now.</p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>", from_customer: false)

ticket4 = Ticket.create!(
  title: "Cancel Subscription ",
  from_email:  Faker::Internet.email,
  customer_name: Faker::Name.name,
  agent_id: 2,
  status_id: 2
)

conversation16 = ticket4.conversations.create!(
  body: "Hey, I would like to cancel the service. Can you help me with that?",
  from_customer: true
)

conversatio17 = ticket4.conversations.create!(
  body: "<p>Hello,</p><p><br></p><p>Sure, may I know the reason for the cancellation?</p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>",
  from_customer: false
)
conversation18 = ticket4.conversations.create!(
  body: "I am not satisfied with the service. I would like to cancel it.",
  from_customer: true
)
conversation19 = ticket4.conversations.create!(
  body: "<p>Hello,</p><p><br></p><p>I am sorry to hear that. I will cancel the service for you.</p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>",
  from_customer: false
)

conversation20 = ticket4.conversations.create!( 
  body: "Thanks for your help. I appreciate it.", 
  from_customer: true
  )

conversation21 = ticket4.conversations.create!(
   body: "<p>Hello,</p><p><br></p><p>Your service has been cancelled. If you need any further assistance, feel free to reach out to us.</p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>", 
   from_customer: false
   )

ticket5 = Ticket.create!(
title: "Getting started with Shopify Question",
from_email:  Faker::Internet.email,
customer_name: Faker::Name.name,
agent_id: 3,
status_id: 1
)

conversation22 = ticket5.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>Do I need to be a designer or developer to use Shopify?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

ticket6 = Ticket.create!(
title: "Dropshipping Question",
from_email:  Faker::Internet.email,
customer_name: Faker::Name.name,
agent_id: 1,
status_id: 1
)

conversation23 = ticket6.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>What is dropshipping, and how can I dropship with Shopify?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

ticket7 = Ticket.create!(
title: "Domain Name Question",
from_email:  Faker::Internet.email,
customer_name: Faker::Name.name,
agent_id: 1,
status_id: 1
)

conversation24 = ticket7.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>Can I use my own domain name with Shopify?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

ticket8 = Ticket.create!(
title: "Getting Started Question",
from_email:  Faker::Internet.email,
customer_name: Faker::Name.name,
agent_id: 1,
status_id: 1
)

conversation24 = ticket8.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>What do I need to start selling on Shopify?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

ticket9 = Ticket.create!(
title: "Receiving Order Question",
from_email:  Faker::Internet.email,
customer_name: Faker::Name.name,
agent_id: 1,
status_id: 1
)

conversation25 = ticket9.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>What happens when I receive an order?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

ticket10 = Ticket.create!(
title: "Available Currencies",
from_email:  "glorialim.dev@gmail.com",
customer_name: "Gloria",
agent_id: 3,
status_id: 1
)

conversation25 = ticket10.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>What currencies does Shopify work with?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

ticket11 = Ticket.create!(
title: "Shipping with Shopify",
from_email:  "glorialim.dev@gmail.com",
customer_name: "Gloria",
agent_id: 2,
status_id: 1
)

conversation26 = ticket11.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>Do I need to ship items myself?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

ticket12 = Ticket.create!(
title: "Third-party payment processor",
from_email:  Faker::Internet.email,
customer_name: Faker::Name.name,
agent_id: 2,
status_id: 2
)

conversation26 = ticket12.conversations.create!(
body: "<p>Hi SmartAgent,</p><p><br></p><p>What is a third-party payment processor?</p><p><br></p><p>Thanks.</p>",
from_customer: true
)

conversation27 = ticket12.conversations.create!(
body: "<p>Hello,</p><p><br></p><p>A third-party payment processor (also knows as a payment provider or&nbsp;<a href='https://www.shopify.com/ca/payment-gateways' rel='noopener noreferrer' target='_blank'>payment gateway</a>) lets you accept online payments.</p><p><br></p><p>Let me know if you have any further questions.</p><p><br></p><p>Regards,</p><p><br></p><p><strong>SmartAgent</strong></p><p>Customer Support</p><p><a href='mailto:smartagents3@gmail.com' rel='noopener noreferrer' target='_blank'>smartagents3@gmail.com</a></p>",
from_customer: false
)
   # db/seeds.rb

# Assuming you have some agents in your database
agent1 = Agent.second
agent2 = Agent.third

# Create some direct chats
DirectChat.create(sender_id: agent1.id, receiver_id: agent2.id, message: "Hello, can you help me with a ticket?")
DirectChat.create(sender_id: agent2.id, receiver_id: agent1.id, message: "Sure, you can transfer it to me with a note")
DirectChat.create(sender_id: agent1.id, receiver_id: agent2.id, message: "Will do, thanks!")
DirectChat.create(sender_id: agent2.id, receiver_id: agent1.id, message: "No problem. I have transferred it back to you with a note.")
DirectChat.create(sender_id: agent1.id, receiver_id: agent2.id, message: "I see it, thanks!")


# 20.times do
#   Ticket.create!(
#     title: Faker::Lorem.sentence(word_count: 3),
#     from_email:  Faker::Internet.email,
#     customer_name: Faker::Name.name,
#     agent_id: [1,2,3,4,5,6,7,8,9,10].sample,
#     status_id: [1,2].sample
#   )
# end

20.times do
  Ticket.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    from_email:  Faker::Internet.email,
    customer_name: Faker::Name.name,
    agent_id: [4,5,6,7,8,9,10].sample,
    status_id: 3
  )
end

Ticket.all.each do |ticket|
  3.times do
    Note.create(
      ticket_id: ticket.id,
      agent_id: [1,2,3,4,5,6,7,8,9,10].sample,
      body: Faker::Lorem.sentence(word_count: 10)
    )
  end
end
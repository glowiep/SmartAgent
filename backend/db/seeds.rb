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
Agent.create(email: 'glorialimartt@gmail.com', full_name: 'Gloria lim', password: 'password',
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
Status.create(description: 'Pending')
Status.create(description: 'Resolved')
# Create some tickets

ticket1 = Ticket.create!(
  title: "Website Traffic Help",
  from_email: Faker::Internet.email,
  customer_name: Faker::Name.name,
  agent_id: 1,
  status_id: 1
)

# Create conversations for the ticket
conversation1 = ticket1.conversations.create!(
  body: "Hello team 
  <br>
  I am touching base to let you know that I am experiencing a significant drop in website traffic.",
  from_customer: true
)
conversation1.attachments.attach(io: File.open(Rails.root.join('public', 'placeholder.jpg')), filename: 'placeholder.jpg')

conversation2 = ticket1.conversations.create!(
  body: "Hi,let me check the issue and get back to you.",
  from_customer: false
)
conversation2.attachments.attach(io: File.open(Rails.root.join('public', 'placeholder.jpg')), filename: 'placeholder.jpg')

conversation3 = ticket1.conversations.create!(
  body: "I have identified the issue and it has been resolved. Your website traffic should be back to normal now.",
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
  status_id: 1
)

# Create conversations for the ticket
conversation5 = ticket2.conversations.create!(
  body: " I am reaching out to get some help with increasing my social media visibility. Can you help me with that?",
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
  agent_id: 1,
  status_id: 1
)

conversation10 = ticket3.conversations.create!(
  body: "I am reaching out to get some help with setting up Facebook ads. Can you help me with that?",
  from_customer: true
)

conversatio11 = ticket3.conversations.create!(
  body: "Sure, I can help you with that. Let me take a look at your social media accounts and get back to you.",
  from_customer: false
)
conversation12 = ticket3.conversations.create!(
  body: "Thanks I will be waiting for your response.",
  from_customer: true
)
conversation13 = ticket3.conversations.create!(
  body: "I have reviewed your social media accounts and the problem may be with your budget. I will make some changes and get back to you.",
  from_customer: false
)

conversation14 = ticket3.conversations.create!( body: "thank you for your help", from_customer: true)

conversation15 = ticket3.conversations.create!( body: "I have made the changes and your ads should be running smoothly now.", from_customer: false)

ticket4 = Ticket.create!(
  title: "Cancel Subscription ",
  from_email:  Faker::Internet.email,
  customer_name: Faker::Name.name,
  agent_id: 1,
  status_id: 1
)

conversation16 = ticket4.conversations.create!(
  body: "Hey, I would like to cancel the service. Can you help me with that?",
  from_customer: true
)

conversatio17 = ticket4.conversations.create!(
  body: "Sure, may I know the reason for the cancellation?",
  from_customer: false
)
conversation18 = ticket4.conversations.create!(
  body: "I am not satisfied with the service. I would like to cancel it.",
  from_customer: true
)
conversation19 = ticket4.conversations.create!(
  body: "I am sorry to hear that. I will cancel the service for you.",
  from_customer: false
)

conversation20 = ticket4.conversations.create!( 
  body: "Thanks for your help. I appreciate it.", 
  from_customer: true
  )

conversation21 = ticket4.conversations.create!(
   body: "Your service has been cancelled. If you need any further assistance, feel free to reach out to us.", 
   from_customer: false
   )

   # db/seeds.rb

# Assuming you have some agents in your database
agent1 = Agent.first
agent2 = Agent.second

# Create some direct chats
DirectChat.create(sender_id: agent1.id, receiver_id: agent2.id, message: "Hello, how can I help you?")
DirectChat.create(sender_id: agent2.id, receiver_id: agent1.id, message: "I have a question about my account.")
DirectChat.create(sender_id: agent1.id, receiver_id: agent2.id, message: "Sure, I'd be happy to help. What's your question?")
DirectChat.create(sender_id: agent2.id, receiver_id: agent1.id, message: "I can't seem to access my account. Can you assist?")
DirectChat.create(sender_id: agent1.id, receiver_id: agent2.id, message: "Of course. Let's see what we can do.")


50.times do
  Ticket.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    from_email:  Faker::Internet.email,
    customer_name: Faker::Name.name,
    agent_id: [1,2,3,4,5,6,7,8,9,10].sample,
    status_id: [1,2,3].sample
  )
end

Ticket.all.each do |ticket|
  3.times do
    Note.create(
      ticket_id: ticket.id,
      body: Faker::Lorem.sentence(word_count: 10)
    )
  end
end
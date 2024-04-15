# test/controllers/api/v1/tickets_controller_test.rb
require 'test_helper'

class Api::V1::TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(3) 
    @response = 'This is the response to the ticket'
  end

  test 'should respond to ticket' do
    assert_difference('ActionMailer::Base.deliveries.size', 1) do
      post respond_api_v1_ticket_url(@ticket), params: { response: @response }
    end

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 'Response sent', json_response['message']

    mail = ActionMailer::Base.deliveries.last
    assert_equal @ticket.request.from_email, mail.to[0]
    assert_equal 'Your ticket has been responded', mail.subject
    assert_equal @response, mail.body.to_s
  end
end
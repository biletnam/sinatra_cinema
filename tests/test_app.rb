ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'
require_relative '../tickets.rb'
require 'test/unit'
require 'rack/test'

class AppTest < Test::Unit::TestCase
    def test_show_logo
        browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
        browser.get '/'
        assert browser.last_response.ok?
        assert browser.last_response.body.include?('Cinema Ticket Shop')
    end

    def test_show_tickets_form
        browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
        browser.get '/tickets'
        assert browser.last_response.ok?
        assert browser.last_response.body.include?('Choose a film')
    end

    def test_post_tickets_succes
        browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
        browser.post '/tickets', {:film => 'Manolito gafotas', :email => 'manolito89@gmail.com'}
        assert browser.last_response.ok?
        assert browser.last_response.body.include?('Manolito gafotas')
        assert browser.last_response.body.include?('manolito89@gmail.com')
    end

    def test_ticket
        tickets = Tickets.new
        new_ticket = tickets.generate_ticket('Evaristo', 'Manolito gafotas')
        encoded_ticket_id = tickets.encode_id_ticket(new_ticket.id_ticket)
        browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
        browser.get '/tickets:ticket_id', :ticket_id => encoded_ticket_id
        assert browser.last_response.body.include?(new_ticket.id_ticket.to_s)
    end
end

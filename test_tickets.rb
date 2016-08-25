require "minitest/autorun"
require_relative "tickets.rb"

class TicketsTests < Minitest::Test
    def setup
        @tickets = Tickets.new
    end

    def test_add_a_ticket
        @tickets.generate_ticket('Javi', 'Back to the future')
        assert_equal 1, @tickets.size 
    end

    def test_add_another_ticket
        @tickets.generate_ticket('Javi', 'Back to the future')
        @tickets.generate_ticket('Emilio', 'Back to the future')
        assert_equal 2 , @tickets.size 
    end

    def test_find_ticket
        ticket = @tickets.generate_ticket('Javi', 'Back to the future')
        encoded_id = @tickets.encode_id_ticket(ticket.id_ticket)
        assert_equal ticket, @tickets.find(encoded_id) 
    end

    def test_return_generate_two_tickets
        first_ticket = @tickets.generate_ticket('Javi', 'Back to the future')
        second_ticket = @tickets.generate_ticket('Emilio', 'Back to the future')
        encoded_id = @tickets.encode_id_ticket(second_ticket.id_ticket)
        assert_equal second_ticket, @tickets.find(encoded_id)
    end

    def test_generate_ticket_for_another_film
        first_ticket = @tickets.generate_ticket('Javi', 'Back to the future')
        second_ticket = @tickets.generate_ticket('Emilio', 'Back to the future')
        third_ticket = @tickets.generate_ticket('Sara', 'Star Wars Episode IV')
        encoded_id = @tickets.encode_id_ticket(third_ticket.id_ticket)
        assert_equal third_ticket, @tickets.find(encoded_id)
    end
end

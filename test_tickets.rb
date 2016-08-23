require "minitest/autorun"
require_relative "tickets.rb"

class TicketsTests < Minitest::Test
    def setup
        @tickets = Tickets.new
    end

    def test_add_a_ticket
        @tickets.generate('Javi', 'Back to the future')
        assert_equal 1 , @tickets.size 
    end

    def test_add_another_ticket
        @tickets.generate('Javi', 'Back to the future')
        @tickets.generate('Emilio', 'Back to the future')
        assert_equal 2 , @tickets.size 
    end

    def test_find_ticket
        @tickets.generate('Javi', 'Back to the future')
        assert_equal [1, 'Javi', 'Back to the future'] , @tickets.find(1) 
    end

    def test_return_generate_one_ticket
        ticket_id = @tickets.generate('Javi', 'Back to the future')
        assert_equal [1, 'Javi', 'Back to the future'], @tickets.find(ticket_id)
    end

    def test_return_generate_two_tickets
        @tickets.generate('Javi', 'Back to the future')
        ticket_id = @tickets.generate('Emilio', 'Back to the future')
        assert_equal [2, 'Emilio', 'Back to the future'], @tickets.find(ticket_id)
    end

    def test_generate_ticket_for_another_film
        @tickets.generate('Javi', 'Back to the future')
        @tickets.generate('Emilio', 'Back to the future')
        ticket_id = @tickets.generate('Emilio', 'Star Wars Episode IV')
        assert_equal [1, 'Emilio', 'Star Wars Episode IV'], @tickets.find(ticket_id)
    end
end

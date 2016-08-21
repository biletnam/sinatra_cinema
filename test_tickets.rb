require "minitest/autorun"
require_relative "tickets.rb"

class TicketsTests < Minitest::Test
    def test_add_a_ticket
        tickets = Tickets.new
        tickets.generate('Javi', 'Back to the future')
        assert_equal 1 , tickets.size 
    end

    def test_find_ticket
        tickets = Tickets.new
        tickets.generate('Javi', 'Back to the future')
        assert_equal ['Javi', 'Back to the future'] , tickets.find(1) 
    end
end

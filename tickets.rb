require_relative 'ticket.rb'
require 'hashids'
class Tickets

    attr_reader :tickets_list
    attr_accessor :film_seats_sold

    def initialize
        @tickets_list = Array.new
        @film_seats_sold = Array.new
        @hashids = Hashids.new("my ticket please")
        @id_ticket = 0
    end

    def generate_ticket(user_name, film)
        @id_ticket += 1
        @film_seats_sold << film
        seat = @film_seats_sold.count(film)
        new_ticket = Ticket.new(@id_ticket, seat, user_name, film)
        @tickets_list << new_ticket
        return new_ticket
    end

    def encode_id_ticket(id_ticket)
        return @hashids.encode(@id_ticket)
    end

    def find(id_ticket) 
        id_ticket_decoded = @hashids.decode(id_ticket)[0] 
        @tickets_list.each do |ticket|
            return ticket if ticket.id_ticket.eql?(id_ticket_decoded)
        end
    end

    def size
        return @tickets_list.size
    end
end

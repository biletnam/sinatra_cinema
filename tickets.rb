class Tickets

    attr_reader :tickets_list
    attr_accessor :film_seats_sold

    def initialize
        @tickets_list = Hash.new
        @ticket_id = 0
        @film_seats_sold = Array.new
    end

    def generate(user_name, film)
        @ticket_id += 1
        @film_seats_sold << film
        seat = @film_seats_sold.count(film)
        @tickets_list[@ticket_id] = [seat, user_name, film]
        return @ticket_id
    end

    def find(ticket_id) 
        return @tickets_list.fetch(ticket_id)
    end

    def size
        return @tickets_list.size
    end
end

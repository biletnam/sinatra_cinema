class Tickets

    attr_reader :tickets_list

    def initialize
        @tickets_list = Hash.new
        @seat_counter = 0
    end

    def generate(user_name, film)
        @seat_counter += 1
        @tickets_list[@seat_counter] = [user_name, film]
    end

    def find(seat) 
        return @tickets_list.fetch(seat)
    end

    def size
        return @tickets_list.size
    end
end

class Ticket
    attr_accessor :id_ticket, :seat, :user_name, :film

    def initialize(id_ticket, seat, user_name, film)
        @id_ticket = id_ticket
        @seat = seat
        @user_name = user_name
        @film = film
    end
end

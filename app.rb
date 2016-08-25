require 'sinatra'
require_relative 'tickets.rb'

configure do
    set :tickets, tickets = Tickets.new 
end

get '/' do
    erb :logo
end

post '/' do
    erb :form
end

post '/form' do
    email = params[:email]
    name = params[:name]
    film = params[:film]

    if email.empty?
        erb :error
    else
        if settings.tickets == nil
            settings.tickets = Tickets.new
        end
        ticket_id = settings.tickets.generate(name, film)

        require 'pony'
        Pony.mail :to => email,
            :from => 'jfernapa@gmail.com',
            :subject => 'Your tickets!',
            :body => erb(:email, :locals => { :name => name, :film => film, :ticket_id => ticket_id }),
            :via => :sendmail

        erb :success, :locals => { :email => email, :film => film, :ticket_id => ticket_id }
    end
end

get '/ticket/:ticket_id' do
    ticket = settings.tickets.find(params[:ticket_id].to_i)
    erb :ticket, :locals => {:seat => ticket[0], :user_name => ticket[1], :film => ticket[2] }
end

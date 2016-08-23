require 'sinatra'
require_relative 'tickets.rb'

set :tickets, Tickets.new 

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
    #TODO Show film, name, seat, etc...
    erb :ticket, :locals => { :ticket_id => params[:ticket_id] }
end

put '/ticket' do
    ticket = settings.tickets.find(params[:id_ticket])
end

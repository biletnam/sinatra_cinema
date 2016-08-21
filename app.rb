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
        ticket = settings.tickets.generate(name, film)
        require 'pony'
        Pony.mail :to => email,
            :from => 'jfernapa@gmail.com',
            :subject => 'Your tickets!',
            :body => erb(:email, :locals => { :name => name, :film => film }),
            :via => :sendmail

        erb :success, :locals => { :email => email, :film => film }
    end
end

get '/ticket' do
    #TODO Show film, name, seat, etc...
end

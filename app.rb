require 'sinatra'
require 'pony'
require_relative 'tickets.rb'

configure do
    set :tickets, tickets = Tickets.new 
end

get '/' do
    erb :logo
end

get '/tickets' do
    erb :tickets
end

post '/tickets' do
    email = params[:email]
    name = params[:name]
    film = params[:film]

    if email.empty?
        erb :error
    else
        ticket = settings.tickets.generate_ticket(name, film)
        ticket_id = settings.tickets.encode_id_ticket(ticket.id_ticket)

        Pony.options = {
            :via => :smtp,
            :via_options => {
                :address => 'smtp:sendgrid.net',
                :port => '587',
                :domain => 'heroku.com',
                :user_name => ENV['SENDGRID_USERNAME'],
                :password => ENV['SENDGRID_PASSWORD'],
                :authentication => :plain,
                :enable_starttls_auto => true
            }
        }

        Pony.mail :to => email,
            :from => 'jfernapa@gmail.com',
            :subject => 'Your tickets!',
            :body => erb(:email, :locals => {
                :name => ticket.user_name,
                :film => ticket.film,
                :ticket_id => ticket_id }),

        erb :success, :locals => { :email => email, :film => film, :ticket_id => ticket_id }
    end
end

get '/tickets/:ticket_id' do
    ticket = settings.tickets.find(params[:ticket_id])
    erb :ticket, :locals => {:seat => ticket.seat, :user_name => ticket.user_name, :film => ticket.film }
end

# app.rb

require 'sinatra'
require 'json'
require 'data_mapper'
require 'dm-serializer'

DataMapper.setup(:default, ENV['DATABASE_URL'])

get '/' do
  @messages = Message.all
  erb :messages
end

get '/all.json' do
	content_type :json do
		@messages = Message.first
		@messages.to_json
	end
end

get '/reset' do
  DataMapper.auto_migrate!
  "Messages reset!"
end

post '/' do
  
  # TODO: Read the message contents, save to the database
  message_contents = request.POST["message"]
  @message_row = Message.new(:body => message_contents)
  @message_row.save

  "Message Posted!"
end

class Message
  
  # TODO: Use this class as a table in the database
  include DataMapper::Resource

  property :id, Serial
  property :body, Text
  property :created_at, DateTime
end

DataMapper.finalize

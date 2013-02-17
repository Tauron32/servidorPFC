require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/store.db")

class Product
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :required => true
  property :created_at, DateTime
end
DataMapper.finalize.auto_upgrade!

get '/' do
  'Hello world!'
end
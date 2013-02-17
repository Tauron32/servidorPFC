require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'json'

DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/store.db")

class Product
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :required => true
  property :created_at, DateTime
  
  def url
      "/product/#{self.id}"
  end
  
  def to_json(*a)
    { 
      'id' => self.id, 
      'name' => self.name,
      'created_at'=> self.created_at
    }.to_json(*a)
  end
  
  # ensure json is safe.  If invalid json is received returns nil
  def self.parse_json(body)
    json = JSON.parse(body)
    ret = { :name => json['name'], :created_at => json['created_at'] }
    return nil if REQUIRED.find { |r| ret[r].nil? }

    ret 
  end
  
end
DataMapper.auto_upgrade!  

# return as JSON
get '/products' do
  content_type 'application/json'
  { 'content' => Array(Product.all) }.to_json
end

get '/product/:id' do
  content_type 'application/json'
  { 'content' => Product.get(params[:id]) }.to_json
end

get '/' do
  @products = Product.all :order => :id.asc
  @title = "All products"
  erb :home
end

get '/new/:name' do
  n = Product.new
  n.name = params[:name]
  n.created_at = Time.now
  n.save
  redirect '/'
end
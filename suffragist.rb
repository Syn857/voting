require 'sinatra'
require 'yaml/store'

get '/' do
  @title = 'Welcome to Suffragist!'
  erb:index
end

post '/cast' do
  @title = 'Thanks for casting your votes!'
  @vote = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@votes] ||= 0
    @store['votes'][@votes] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes']}
  erb :results
end


Choices = {
    'HAM' => 'Hamburger',
    'PIZ' => 'Pizza',
    'CUR' => 'Curry',
    'NOO' => 'Noodles',
}
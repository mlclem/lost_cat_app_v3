# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require 'sinatra/base'
require 'sinatra/reloader'

# You will want to require your data model class here
require "database_connection"
require "animals_table"
require "animal_entity"
require "cat_entity"
require "cats_table"

class WebApplicationServer < Sinatra::Base
  # This line allows us to send HTTP Verbs like `DELETE` using forms
  use Rack::MethodOverride

  configure :development do
    # In development mode (which you will be running) this enables the tool
    # to reload the server when your code changes
    register Sinatra::Reloader

    # In development mode, connect to the development database
    db = DatabaseConnection.new("localhost", "web_application_dev")
    $global = { db: db }
  end

  configure :test do
    # In test mode, connect to the test database
    db = DatabaseConnection.new("localhost", "web_application_test")
    $global = { db: db }
  end

  def animals_table
    $global[:animals_table] ||= AnimalsTable.new($global[:db])
  end

  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE

  def cats_table
    $global[:cats_table] ||= CatsTable.new($global[:db])
  end

  # Read - list all
  get '/lostcats' do
    erb :cat_adverts_index, locals: { cats_list: cats_table.list }
  end  
  
  # Create
  get '/lostcats/new' do
    erb :cat_adverts_new
  end
  
  # Post new cat
  post '/lostcats' do
    cat_advert = CatEntity.new(
      params[:name], params[:phone], params[:description], 
      params[:password],params[:img_url]
    )
    cats_table.add(cat_advert)
    redirect '/lostcats'
  end

  # Update 
  get '/lostcats/:index/edit' do
    index = (params[:index].to_i + 1)
    cat = cats_table.get(index)
    erb :cat_adverts_edit, locals: { cat: cat, index: index }
  end

  patch '/lostcats/:index' do
    index = params[:index].to_i
    name = params[:name]
    phone = params[:phone]
    description = params[:description]
    password = params[:password]
    img_url = params[:img_url]
    new_cat = CatEntity.new(name, phone, description, password, img_url)
    cats_table.update(index, new_cat)
    redirect '/lostcats'
  end

  # Delete
  delete '/lostcats/:index' do
    index = (params[:index].to_i + 1)
    cats_table.remove(index)
    redirect '/lostcats'
  end

  # Sightings
  get '/lostcats/:index/sightings' do
    index = (params[:index].to_i + 1)
    cat = cats_table.get(index)
    erb :cat_adverts_sightings, locals: { cat: cat, index: index }
  end

  # EXAMPLE ROUTES

  get '/animals' do
    erb :animals_index, locals: { animals: animals_table.list }
  end

  get '/animals/new' do
    erb :animals_new
  end

  post '/animals' do
    animal = AnimalEntity.new(params[:species])
    animals_table.add(animal)
    redirect '/animals'
  end

  delete '/animals/:index' do
    animals_table.remove(params[:index].to_i)
    redirect '/animals'
  end

  get '/animals/:index/edit' do
    animal_index = params[:index].to_i
    erb :animals_edit, locals: {
      index: animal_index,
      animal: animals_table.get(animal_index)
    }
  end

  patch '/animals/:index' do
    animal_index = params[:index].to_i
    animals_table.update(animal_index, params[:species])
    redirect '/animals'
  end
end

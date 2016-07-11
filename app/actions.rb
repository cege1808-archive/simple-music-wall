# Homepage (Root path)

enable :sessions

get '/' do
  @current_user = session["value"]
  # session["value"] ||= "Hello world!"
  "The cookie you've created contains the value: #{session["value"]}"
  erb :index
end

helpers do 
  def current_user
    #session['whatever'] will be nil if it's not present in the session
    user_id = session['user_id']
    @current_user ||= User.find(username: session[:user]) if session[:user]
  end

  def logged_in?
    !current_user.nil?
  end
end

get '/sessions/new' do
  @users = User.new
  erb :'sessions/new'
end 


post '/sessions' do
  if (params[:username] == "a username") && (params[:password] == "a username")
    #login
    session[:user] = "user id or username"
  end
  
end

#log out
# TODO make a form link thingy
delete '/sessions' do
  session[:user] = nil
  redirect '/'
end

get '/tracks/' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @tracks = Track.new
  erb :'tracks/new'
end

get '/tracks/:id' do
  @tracks = Track.find params[:id]
  erb :'tracks/show'
end

post '/tracks' do 
  # binding.pry
  @tracks = Track.new(
    title: params[:title],
    artist: params[:artist],
    url: params[:url]
  )
  if @tracks.save
    redirect '/tracks/'
  else
    erb :'/tracks/new'
  end
end
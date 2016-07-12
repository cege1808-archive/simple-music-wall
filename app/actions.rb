# Homepage (Root path)

enable :sessions

get '/' do
  @current_user = "claire" #session[:user]
  erb :index
end

# helpers do 
#   def current_user
#     @current_user ||= User.find(username: session[:user]) if session[:user]
#   end

#   def logged_in?
#     !@current_user.nil?
#   end
# end

get '/user/new' do
  @current_user = User.new
  erb :'user/new'
end



get '/sessions/new' do
  @current_user = User.new
  erb :'sessions/new'
end 

post '/sessions' do
  @user1 = User.find_by(username: params[:username])
  if !@user1.nil?
    if @user1.password == params[:password] 
      @current_user = @user1
      redirect '/tracks'
    end
  end
    redirect '/sessions/error'
end

#log out
# TODO make a form link thingy
delete '/sessions' do
  session[:user] = nil
  redirect '/'
end


# Tracks (Music)
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
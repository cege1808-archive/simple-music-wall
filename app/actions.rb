# Homepage (Root path)
before do
  if cookies[:page_views]
    cookies[:page_views] = cookies[:page_views].to_i + 1
  else
    cookies[:page_views] = 1
  end
end

# enable :sessions

get '/' do
  @current_user = session[:user]
  erb :index
end

helpers do 
  def current_user
    @current_user ||= User.find(username: session[:user]) if session[:user]
  end

  def logged_in?
    !@current_user.nil?
  end
end

# Sign Up
get '/users/new' do
  @user = User.new
  erb :'/users/new'
end

post '/users' do
  @user = User.new(
    username: params[:username],
    email: params[:email])
  @user.password = params[:password]

  if params[:password] == params[:confirm_password]
    if @user.save
      redirect '/tracks'
    end
  end
  erb :'/users/new'
end

# Log In
get '/sessions/new' do
  @user = User.new
  erb :'sessions/new'
end 

post '/sessions' do
  @user = User.find_by(username: params[:username])
  if @user and @user.password == params[:password] 
    session[:user_id] = @user.id
    redirect '/tracks'
  else
    @error = "Username or password incorrect"
    erb :'/sessions/new'
  end
end


#log out
# TODO make a form link thingy
get '/sessions' do
  session.delete(:user_id)
  #flash
  redirect '/'
end


# Tracks (Music)
get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @tracks = Track.new
  erb :'tracks/new'
end

get '/tracks/:track_id' do
  @tracks = Track.find params[:track_id]
  erb :'tracks/show'
end

post '/upvote/:track_id' do
  searched_vote = Vote.where(track_id: params[:track_id]).where(user_id: session[:user_id])

  if searched_vote.length > 0
    #down vote
    Vote.destroy(searched_vote)
  else
    # up vote
    @vote = Vote.new(
      track_id: params[:track_id],
      user_id: session[:user_id]
      )
    @vote.save
  end
  
 redirect '/tracks'
end

post '/tracks' do 
    @tracks = Track.new(
      title: params[:title],
      artist: params[:artist],
      url: params[:url],
      user_id: session[:user_id]
    )
    if @tracks.save
      redirect '/tracks'
    else
      erb :'/tracks/new'
    end

end
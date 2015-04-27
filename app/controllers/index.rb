get "/" do
  unless session[:user_id] == nil
  @user = User.find(session[:user_id])
  end
  erb :index
end

get "/teams/new" do
  erb :new
end

post "/teams" do
  coach = User.find(params[:coach_id])
  team = Team.create(name: params[:name],
                      sport: params[:sport],
                      coach: coach)
  if request.xhr?
    content_type :json
    { team: team }.to_json
  else
    redirect "/teams/#{team.id}"
  end
end

get "/teams/:team_id" do
  @team = Team.find(params[:team_id])
  erb :show
end

get "/teams/:team_id/edit" do
  @team = Team.find(params[:team_id])
  erb :edit
end

put "/teams/:team_id" do
  team = Team.find(params[:team_id])
  team.update_attributes(params[:team])
    redirect "/teams/#{team.id}"
end

delete "/teams/:team_id" do
  team = Team.find(params[:team_id])
  team.destroy
    redirect "/"
end

get "/signin" do
  erb :signin
end

post "/signin" do
  username = params[:username]
  user = User.authenticate(username, params[:password])
  if user
    session[:user_id] = user.id
    if request.xhr?
      content_type :json
      {user: user}.to_json
    else
      redirect "/"
    end
  else
    @error = "Invalid email or password."
    erb :index
  end
end

get "/users/new" do
  erb :signup
end

post "/users" do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect "/"
  else
    @error = "Invalid username or password."
    erb :signup
  end
end

get "/logout" do
  session.clear
  redirect "/"
end

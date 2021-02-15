class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  skip_before_action :verify_authenticity_token

  def index
    render plain: "Index page of users"
  end

  def show
    id = params[:id]
    user = User.find(id)
    render plain: user.to_displayable_string
  end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    password = params[:password]

    user = User.new(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password
    )

    if user.save
      session[:current_user_id] = user.id
      redirect_to todos_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def login
    email = params[:email]
    password = params[:password]
    user = User.where("email = ? and password = ?", email, password)
    render plain: (user.count != 0)
  end

  def new
    render "users/new"
  end
end
class Admin::UsersController < Admin::AdminController
  responders :flash

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :layout => false
  end

end

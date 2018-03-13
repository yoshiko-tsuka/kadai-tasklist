class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
  end

  def show
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'registed!'
      redirect_to @user
    else
      flash.now[:danger] = 'failure to regist'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end

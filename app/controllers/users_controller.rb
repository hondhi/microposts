class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
   @following = @user.microposts.order(created_at: :desc)
   @follower = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Updated your Plofile"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following_users#.page(params[:page]).per(1)
    #@users = User.find(parms[:id]).following_users
    render 'show_follow'
  end
  
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.follower_users#.page(params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location, :comment)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
end

class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.paginates_per
  end

  def show
    @microposts = @user.microposts.order_by_created_desc.page(params[:page]).per Settings.paginates_per
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "static_pages.users.mesage_check_mail"
      redirect_to root_path
    else
      flash.now[:danger] = t "static_pages.users.fail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "static_pages.edit_user.update_success"
      redirect_to @user
    else
      flash.now[:danger] = t "static_pages.edit_user.update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "static_pages.users.deleted"
    else
      flash[:danger] = t "static_pages.users.delete_fail"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end

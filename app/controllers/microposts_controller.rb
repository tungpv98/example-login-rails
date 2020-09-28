class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t "static_pages.micropost_controller.flash_created"
      redirect_to root_path
    else
      flash[:info] = t "static_pages.micropost_controller.flash_create_fail"
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "static_pages.micropost_controller.flash_deleted"
      redirect_to request.referrer || root_path
    else
      flash[:danger] = t "static_pages.micropost_controller.flash_delete_fail"
      redirect_to root_path
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::MICROPOST_PARAMS
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_path unless @micropost
  end
end

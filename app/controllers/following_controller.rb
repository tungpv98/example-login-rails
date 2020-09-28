class FollowingController < ApplicationController
  before_action :load_user

  def index
    @title = t ".following_title"
    @users = @user.following.page(params[:page]).per Settings.paginates_per
    render "users/show_follow"
  end
end
